# copies.py - copy detection for Mercurial
#
# Copyright 2008 Matt Mackall <mpm@selenic.com>
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2 or any later version.

from __future__ import absolute_import

import collections
import os

from .i18n import _


from . import (
    match as matchmod,
    node,
    pathutil,
    pycompat,
    util,
)


from .utils import stringutil

from .revlogutils import flagutil


def _filter(src, dst, t):
    """filters out invalid copies after chaining"""

    # When _chain()'ing copies in 'a' (from 'src' via some other commit 'mid')
    # with copies in 'b' (from 'mid' to 'dst'), we can get the different cases
    # in the following table (not including trivial cases). For example, case 2
    # is where a file existed in 'src' and remained under that name in 'mid' and
    # then was renamed between 'mid' and 'dst'.
    #
    # case src mid dst result
    #   1   x   y   -    -
    #   2   x   y   y   x->y
    #   3   x   y   x    -
    #   4   x   y   z   x->z
    #   5   -   x   y    -
    #   6   x   x   y   x->y
    #
    # _chain() takes care of chaining the copies in 'a' and 'b', but it
    # cannot tell the difference between cases 1 and 2, between 3 and 4, or
    # between 5 and 6, so it includes all cases in its result.
    # Cases 1, 3, and 5 are then removed by _filter().

    for k, v in list(t.items()):
        # remove copies from files that didn't exist
        if v not in src:
            del t[k]
        # remove criss-crossed copies
        elif k in src and v in dst:
            del t[k]
        # remove copies to files that were then removed
        elif k not in dst:
            del t[k]


def _chain(prefix, suffix):
    """chain two sets of copies 'prefix' and 'suffix'"""
    result = prefix.copy()
    for key, value in pycompat.iteritems(suffix):
        result[key] = prefix.get(value, value)
    return result


def _tracefile(fctx, am, basemf):
    """return file context that is the ancestor of fctx present in ancestor
    manifest am

    Note: we used to try and stop after a given limit, however checking if that
    limit is reached turned out to be very expensive. we are better off
    disabling that feature."""

    for f in fctx.ancestors():
        path = f.path()
        if am.get(path, None) == f.filenode():
            return path
        if basemf and basemf.get(path, None) == f.filenode():
            return path


def _dirstatecopies(repo, match=None):
    ds = repo.dirstate
    c = ds.copies().copy()
    for k in list(c):
        if ds[k] not in b'anm' or (match and not match(k)):
            del c[k]
    return c


def _computeforwardmissing(a, b, match=None):
    """Computes which files are in b but not a.
    This is its own function so extensions can easily wrap this call to see what
    files _forwardcopies is about to process.
    """
    ma = a.manifest()
    mb = b.manifest()
    return mb.filesnotin(ma, match=match)


def usechangesetcentricalgo(repo):
    """Checks if we should use changeset-centric copy algorithms"""
    if repo.filecopiesmode == b'changeset-sidedata':
        return True
    readfrom = repo.ui.config(b'experimental', b'copies.read-from')
    changesetsource = (b'changeset-only', b'compatibility')
    return readfrom in changesetsource


def _committedforwardcopies(a, b, base, match):
    """Like _forwardcopies(), but b.rev() cannot be None (working copy)"""
    # files might have to be traced back to the fctx parent of the last
    # one-side-only changeset, but not further back than that
    repo = a._repo

    if usechangesetcentricalgo(repo):
        return _changesetforwardcopies(a, b, match)

    debug = repo.ui.debugflag and repo.ui.configbool(b'devel', b'debug.copies')
    dbg = repo.ui.debug
    if debug:
        dbg(b'debug.copies:    looking into rename from %s to %s\n' % (a, b))
    am = a.manifest()
    basemf = None if base is None else base.manifest()

    # find where new files came from
    # we currently don't try to find where old files went, too expensive
    # this means we can miss a case like 'hg rm b; hg cp a b'
    cm = {}

    # Computing the forward missing is quite expensive on large manifests, since
    # it compares the entire manifests. We can optimize it in the common use
    # case of computing what copies are in a commit versus its parent (like
    # during a rebase or histedit). Note, we exclude merge commits from this
    # optimization, since the ctx.files() for a merge commit is not correct for
    # this comparison.
    forwardmissingmatch = match
    if b.p1() == a and b.p2().node() == node.nullid:
        filesmatcher = matchmod.exact(b.files())
        forwardmissingmatch = matchmod.intersectmatchers(match, filesmatcher)
    missing = _computeforwardmissing(a, b, match=forwardmissingmatch)

    ancestrycontext = a._repo.changelog.ancestors([b.rev()], inclusive=True)

    if debug:
        dbg(b'debug.copies:      missing files to search: %d\n' % len(missing))

    for f in sorted(missing):
        if debug:
            dbg(b'debug.copies:        tracing file: %s\n' % f)
        fctx = b[f]
        fctx._ancestrycontext = ancestrycontext

        if debug:
            start = util.timer()
        opath = _tracefile(fctx, am, basemf)
        if opath:
            if debug:
                dbg(b'debug.copies:          rename of: %s\n' % opath)
            cm[f] = opath
        if debug:
            dbg(
                b'debug.copies:          time: %f seconds\n'
                % (util.timer() - start)
            )
    return cm


def _revinfo_getter(repo):
    """returns a function that returns the following data given a <rev>"

    * p1: revision number of first parent
    * p2: revision number of first parent
    * changes: a ChangingFiles object
    """
    cl = repo.changelog
    parents = cl.parentrevs
    flags = cl.flags

    HASCOPIESINFO = flagutil.REVIDX_HASCOPIESINFO

    changelogrevision = cl.changelogrevision

    # A small cache to avoid doing the work twice for merges
    #
    # In the vast majority of cases, if we ask information for a revision
    # about 1 parent, we'll later ask it for the other. So it make sense to
    # keep the information around when reaching the first parent of a merge
    # and dropping it after it was provided for the second parents.
    #
    # It exists cases were only one parent of the merge will be walked. It
    # happens when the "destination" the copy tracing is descendant from a
    # new root, not common with the "source". In that case, we will only walk
    # through merge parents that are descendant of changesets common
    # between "source" and "destination".
    #
    # With the current case implementation if such changesets have a copy
    # information, we'll keep them in memory until the end of
    # _changesetforwardcopies. We don't expect the case to be frequent
    # enough to matters.
    #
    # In addition, it would be possible to reach pathological case, were
    # many first parent are met before any second parent is reached. In
    # that case the cache could grow. If this even become an issue one can
    # safely introduce a maximum cache size. This would trade extra CPU/IO
    # time to save memory.
    merge_caches = {}

    def revinfo(rev):
        p1, p2 = parents(rev)
        value = None
        e = merge_caches.pop(rev, None)
        if e is not None:
            return e
        changes = None
        if flags(rev) & HASCOPIESINFO:
            changes = changelogrevision(rev).changes
        value = (p1, p2, changes)
        if p1 != node.nullrev and p2 != node.nullrev:
            # XXX some case we over cache, IGNORE
            merge_caches[rev] = value
        return value

    return revinfo


def _changesetforwardcopies(a, b, match):
    if a.rev() in (node.nullrev, b.rev()):
        return {}

    repo = a.repo().unfiltered()
    children = {}

    cl = repo.changelog
    isancestor = cl.isancestorrev  # XXX we should had chaching to this.
    missingrevs = cl.findmissingrevs(common=[a.rev()], heads=[b.rev()])
    mrset = set(missingrevs)
    roots = set()
    for r in missingrevs:
        for p in cl.parentrevs(r):
            if p == node.nullrev:
                continue
            if p not in children:
                children[p] = [r]
            else:
                children[p].append(r)
            if p not in mrset:
                roots.add(p)
    if not roots:
        # no common revision to track copies from
        return {}
    min_root = min(roots)

    from_head = set(
        cl.reachableroots(min_root, [b.rev()], list(roots), includepath=True)
    )

    iterrevs = set(from_head)
    iterrevs &= mrset
    iterrevs.update(roots)
    iterrevs.remove(b.rev())
    revs = sorted(iterrevs)

    if repo.filecopiesmode == b'changeset-sidedata':
        revinfo = _revinfo_getter(repo)
        return _combine_changeset_copies(
            revs, children, b.rev(), revinfo, match, isancestor
        )
    else:
        revinfo = _revinfo_getter_extra(repo)
        return _combine_changeset_copies_extra(
            revs, children, b.rev(), revinfo, match, isancestor
        )


def _combine_changeset_copies(
    revs, children, targetrev, revinfo, match, isancestor
):
    """combine the copies information for each item of iterrevs

    revs: sorted iterable of revision to visit
    children: a {parent: [children]} mapping.
    targetrev: the final copies destination revision (not in iterrevs)
    revinfo(rev): a function that return (p1, p2, p1copies, p2copies, removed)
    match: a matcher

    It returns the aggregated copies information for `targetrev`.
    """
    all_copies = {}
    alwaysmatch = match.always()
    for r in revs:
        copies = all_copies.pop(r, None)
        if copies is None:
            # this is a root
            copies = {}
        for i, c in enumerate(children[r]):
            p1, p2, changes = revinfo(c)
            childcopies = {}
            if r == p1:
                parent = 1
                if changes is not None:
                    childcopies = changes.copied_from_p1
            else:
                assert r == p2
                parent = 2
                if changes is not None:
                    childcopies = changes.copied_from_p2
            if not alwaysmatch:
                childcopies = {
                    dst: src for dst, src in childcopies.items() if match(dst)
                }
            newcopies = copies
            if childcopies:
                newcopies = copies.copy()
                for dest, source in pycompat.iteritems(childcopies):
                    prev = copies.get(source)
                    if prev is not None and prev[1] is not None:
                        source = prev[1]
                    newcopies[dest] = (c, source)
                assert newcopies is not copies
            if changes is not None:
                for f in changes.removed:
                    if f in newcopies:
                        if newcopies is copies:
                            # copy on write to avoid affecting potential other
                            # branches.  when there are no other branches, this
                            # could be avoided.
                            newcopies = copies.copy()
                        newcopies[f] = (c, None)
            othercopies = all_copies.get(c)
            if othercopies is None:
                all_copies[c] = newcopies
            else:
                # we are the second parent to work on c, we need to merge our
                # work with the other.
                #
                # In case of conflict, parent 1 take precedence over parent 2.
                # This is an arbitrary choice made anew when implementing
                # changeset based copies. It was made without regards with
                # potential filelog related behavior.
                if parent == 1:
                    _merge_copies_dict(
                        othercopies, newcopies, isancestor, changes
                    )
                else:
                    _merge_copies_dict(
                        newcopies, othercopies, isancestor, changes
                    )
                    all_copies[c] = newcopies

    final_copies = {}
    for dest, (tt, source) in all_copies[targetrev].items():
        if source is not None:
            final_copies[dest] = source
    return final_copies


def _merge_copies_dict(minor, major, isancestor, changes):
    """merge two copies-mapping together, minor and major

    In case of conflict, value from "major" will be picked.

    - `isancestors(low_rev, high_rev)`: callable return True if `low_rev` is an
                                        ancestors of `high_rev`,

    - `ismerged(path)`: callable return True if `path` have been merged in the
                        current revision,
    """
    for dest, value in major.items():
        other = minor.get(dest)
        if other is None:
            minor[dest] = value
        else:
            new_tt = value[0]
            other_tt = other[0]
            if value[1] == other[1]:
                continue
            # content from "major" wins, unless it is older
            # than the branch point or there is a merge
            if new_tt == other_tt:
                minor[dest] = value
            elif (
                changes is not None
                and value[1] is None
                and dest in changes.salvaged
            ):
                pass
            elif (
                changes is not None
                and other[1] is None
                and dest in changes.salvaged
            ):
                minor[dest] = value
            elif changes is not None and dest in changes.merged:
                minor[dest] = value
            elif not isancestor(new_tt, other_tt):
                minor[dest] = value


def _revinfo_getter_extra(repo):
    """return a function that return multiple data given a <rev>"i

    * p1: revision number of first parent
    * p2: revision number of first parent
    * p1copies: mapping of copies from p1
    * p2copies: mapping of copies from p2
    * removed: a list of removed files
    * ismerged: a callback to know if file was merged in that revision
    """
    cl = repo.changelog
    parents = cl.parentrevs

    def get_ismerged(rev):
        ctx = repo[rev]

        def ismerged(path):
            if path not in ctx.files():
                return False
            fctx = ctx[path]
            parents = fctx._filelog.parents(fctx._filenode)
            nb_parents = 0
            for n in parents:
                if n != node.nullid:
                    nb_parents += 1
            return nb_parents >= 2

        return ismerged

    def revinfo(rev):
        p1, p2 = parents(rev)
        ctx = repo[rev]
        p1copies, p2copies = ctx._copies
        removed = ctx.filesremoved()
        return p1, p2, p1copies, p2copies, removed, get_ismerged(rev)

    return revinfo


def _combine_changeset_copies_extra(
    revs, children, targetrev, revinfo, match, isancestor
):
    """version of `_combine_changeset_copies` that works with the Google
    specific "extra" based storage for copy information"""
    all_copies = {}
    alwaysmatch = match.always()
    for r in revs:
        copies = all_copies.pop(r, None)
        if copies is None:
            # this is a root
            copies = {}
        for i, c in enumerate(children[r]):
            p1, p2, p1copies, p2copies, removed, ismerged = revinfo(c)
            if r == p1:
                parent = 1
                childcopies = p1copies
            else:
                assert r == p2
                parent = 2
                childcopies = p2copies
            if not alwaysmatch:
                childcopies = {
                    dst: src for dst, src in childcopies.items() if match(dst)
                }
            newcopies = copies
            if childcopies:
                newcopies = copies.copy()
                for dest, source in pycompat.iteritems(childcopies):
                    prev = copies.get(source)
                    if prev is not None and prev[1] is not None:
                        source = prev[1]
                    newcopies[dest] = (c, source)
                assert newcopies is not copies
            for f in removed:
                if f in newcopies:
                    if newcopies is copies:
                        # copy on write to avoid affecting potential other
                        # branches.  when there are no other branches, this
                        # could be avoided.
                        newcopies = copies.copy()
                    newcopies[f] = (c, None)
            othercopies = all_copies.get(c)
            if othercopies is None:
                all_copies[c] = newcopies
            else:
                # we are the second parent to work on c, we need to merge our
                # work with the other.
                #
                # In case of conflict, parent 1 take precedence over parent 2.
                # This is an arbitrary choice made anew when implementing
                # changeset based copies. It was made without regards with
                # potential filelog related behavior.
                if parent == 1:
                    _merge_copies_dict_extra(
                        othercopies, newcopies, isancestor, ismerged
                    )
                else:
                    _merge_copies_dict_extra(
                        newcopies, othercopies, isancestor, ismerged
                    )
                    all_copies[c] = newcopies

    final_copies = {}
    for dest, (tt, source) in all_copies[targetrev].items():
        if source is not None:
            final_copies[dest] = source
    return final_copies


def _merge_copies_dict_extra(minor, major, isancestor, ismerged):
    """version of `_merge_copies_dict` that works with the Google
    specific "extra" based storage for copy information"""
    for dest, value in major.items():
        other = minor.get(dest)
        if other is None:
            minor[dest] = value
        else:
            new_tt = value[0]
            other_tt = other[0]
            if value[1] == other[1]:
                continue
            # content from "major" wins, unless it is older
            # than the branch point or there is a merge
            if (
                new_tt == other_tt
                or not isancestor(new_tt, other_tt)
                or ismerged(dest)
            ):
                minor[dest] = value


def _forwardcopies(a, b, base=None, match=None):
    """find {dst@b: src@a} copy mapping where a is an ancestor of b"""

    if base is None:
        base = a
    match = a.repo().narrowmatch(match)
    # check for working copy
    if b.rev() is None:
        cm = _committedforwardcopies(a, b.p1(), base, match)
        # combine copies from dirstate if necessary
        copies = _chain(cm, _dirstatecopies(b._repo, match))
    else:
        copies = _committedforwardcopies(a, b, base, match)
    return copies


def _backwardrenames(a, b, match):
    if a._repo.ui.config(b'experimental', b'copytrace') == b'off':
        return {}

    # Even though we're not taking copies into account, 1:n rename situations
    # can still exist (e.g. hg cp a b; hg mv a c). In those cases we
    # arbitrarily pick one of the renames.
    # We don't want to pass in "match" here, since that would filter
    # the destination by it. Since we're reversing the copies, we want
    # to filter the source instead.
    f = _forwardcopies(b, a)
    r = {}
    for k, v in sorted(pycompat.iteritems(f)):
        if match and not match(v):
            continue
        # remove copies
        if v in a:
            continue
        r[v] = k
    return r


def pathcopies(x, y, match=None):
    """find {dst@y: src@x} copy mapping for directed compare"""
    repo = x._repo
    debug = repo.ui.debugflag and repo.ui.configbool(b'devel', b'debug.copies')
    if debug:
        repo.ui.debug(
            b'debug.copies: searching copies from %s to %s\n' % (x, y)
        )
    if x == y or not x or not y:
        return {}
    if y.rev() is None and x == y.p1():
        if debug:
            repo.ui.debug(b'debug.copies: search mode: dirstate\n')
        # short-circuit to avoid issues with merge states
        return _dirstatecopies(repo, match)
    a = y.ancestor(x)
    if a == x:
        if debug:
            repo.ui.debug(b'debug.copies: search mode: forward\n')
        copies = _forwardcopies(x, y, match=match)
    elif a == y:
        if debug:
            repo.ui.debug(b'debug.copies: search mode: backward\n')
        copies = _backwardrenames(x, y, match=match)
    else:
        if debug:
            repo.ui.debug(b'debug.copies: search mode: combined\n')
        base = None
        if a.rev() != node.nullrev:
            base = x
        copies = _chain(
            _backwardrenames(x, a, match=match),
            _forwardcopies(a, y, base, match=match),
        )
    _filter(x, y, copies)
    return copies


def mergecopies(repo, c1, c2, base):
    """
    Finds moves and copies between context c1 and c2 that are relevant for
    merging. 'base' will be used as the merge base.

    Copytracing is used in commands like rebase, merge, unshelve, etc to merge
    files that were moved/ copied in one merge parent and modified in another.
    For example:

    o          ---> 4 another commit
    |
    |   o      ---> 3 commit that modifies a.txt
    |  /
    o /        ---> 2 commit that moves a.txt to b.txt
    |/
    o          ---> 1 merge base

    If we try to rebase revision 3 on revision 4, since there is no a.txt in
    revision 4, and if user have copytrace disabled, we prints the following
    message:

    ```other changed <file> which local deleted```

    Returns a tuple where:

    "branch_copies" an instance of branch_copies.

    "diverge" is a mapping of source name -> list of destination names
    for divergent renames.

    This function calls different copytracing algorithms based on config.
    """
    # avoid silly behavior for update from empty dir
    if not c1 or not c2 or c1 == c2:
        return branch_copies(), branch_copies(), {}

    narrowmatch = c1.repo().narrowmatch()

    # avoid silly behavior for parent -> working dir
    if c2.node() is None and c1.node() == repo.dirstate.p1():
        return (
            branch_copies(_dirstatecopies(repo, narrowmatch)),
            branch_copies(),
            {},
        )

    copytracing = repo.ui.config(b'experimental', b'copytrace')
    if stringutil.parsebool(copytracing) is False:
        # stringutil.parsebool() returns None when it is unable to parse the
        # value, so we should rely on making sure copytracing is on such cases
        return branch_copies(), branch_copies(), {}

    if usechangesetcentricalgo(repo):
        # The heuristics don't make sense when we need changeset-centric algos
        return _fullcopytracing(repo, c1, c2, base)

    # Copy trace disabling is explicitly below the node == p1 logic above
    # because the logic above is required for a simple copy to be kept across a
    # rebase.
    if copytracing == b'heuristics':
        # Do full copytracing if only non-public revisions are involved as
        # that will be fast enough and will also cover the copies which could
        # be missed by heuristics
        if _isfullcopytraceable(repo, c1, base):
            return _fullcopytracing(repo, c1, c2, base)
        return _heuristicscopytracing(repo, c1, c2, base)
    else:
        return _fullcopytracing(repo, c1, c2, base)


def _isfullcopytraceable(repo, c1, base):
    """ Checks that if base, source and destination are all no-public branches,
    if yes let's use the full copytrace algorithm for increased capabilities
    since it will be fast enough.

    `experimental.copytrace.sourcecommitlimit` can be used to set a limit for
    number of changesets from c1 to base such that if number of changesets are
    more than the limit, full copytracing algorithm won't be used.
    """
    if c1.rev() is None:
        c1 = c1.p1()
    if c1.mutable() and base.mutable():
        sourcecommitlimit = repo.ui.configint(
            b'experimental', b'copytrace.sourcecommitlimit'
        )
        commits = len(repo.revs(b'%d::%d', base.rev(), c1.rev()))
        return commits < sourcecommitlimit
    return False


def _checksinglesidecopies(
    src, dsts1, m1, m2, mb, c2, base, copy, renamedelete
):
    if src not in m2:
        # deleted on side 2
        if src not in m1:
            # renamed on side 1, deleted on side 2
            renamedelete[src] = dsts1
    elif src not in mb:
        # Work around the "short-circuit to avoid issues with merge states"
        # thing in pathcopies(): pathcopies(x, y) can return a copy where the
        # destination doesn't exist in y.
        pass
    elif mb[src] != m2[src] and not _related(c2[src], base[src]):
        return
    elif mb[src] != m2[src] or mb.flags(src) != m2.flags(src):
        # modified on side 2
        for dst in dsts1:
            copy[dst] = src


class branch_copies(object):
    """Information about copies made on one side of a merge/graft.

    "copy" is a mapping from destination name -> source name,
    where source is in c1 and destination is in c2 or vice-versa.

    "movewithdir" is a mapping from source name -> destination name,
    where the file at source present in one context but not the other
    needs to be moved to destination by the merge process, because the
    other context moved the directory it is in.

    "renamedelete" is a mapping of source name -> list of destination
    names for files deleted in c1 that were renamed in c2 or vice-versa.

    "dirmove" is a mapping of detected source dir -> destination dir renames.
    This is needed for handling changes to new files previously grafted into
    renamed directories.
    """

    def __init__(
        self, copy=None, renamedelete=None, dirmove=None, movewithdir=None
    ):
        self.copy = {} if copy is None else copy
        self.renamedelete = {} if renamedelete is None else renamedelete
        self.dirmove = {} if dirmove is None else dirmove
        self.movewithdir = {} if movewithdir is None else movewithdir

    def __repr__(self):
        return (
            '<branch_copies\n  copy=%r\n  renamedelete=%r\n  dirmove=%r\n  movewithdir=%r\n>'
            % (self.copy, self.renamedelete, self.dirmove, self.movewithdir,)
        )


def _fullcopytracing(repo, c1, c2, base):
    """ The full copytracing algorithm which finds all the new files that were
    added from merge base up to the top commit and for each file it checks if
    this file was copied from another file.

    This is pretty slow when a lot of changesets are involved but will track all
    the copies.
    """
    m1 = c1.manifest()
    m2 = c2.manifest()
    mb = base.manifest()

    copies1 = pathcopies(base, c1)
    copies2 = pathcopies(base, c2)

    if not (copies1 or copies2):
        return branch_copies(), branch_copies(), {}

    inversecopies1 = {}
    inversecopies2 = {}
    for dst, src in copies1.items():
        inversecopies1.setdefault(src, []).append(dst)
    for dst, src in copies2.items():
        inversecopies2.setdefault(src, []).append(dst)

    copy1 = {}
    copy2 = {}
    diverge = {}
    renamedelete1 = {}
    renamedelete2 = {}
    allsources = set(inversecopies1) | set(inversecopies2)
    for src in allsources:
        dsts1 = inversecopies1.get(src)
        dsts2 = inversecopies2.get(src)
        if dsts1 and dsts2:
            # copied/renamed on both sides
            if src not in m1 and src not in m2:
                # renamed on both sides
                dsts1 = set(dsts1)
                dsts2 = set(dsts2)
                # If there's some overlap in the rename destinations, we
                # consider it not divergent. For example, if side 1 copies 'a'
                # to 'b' and 'c' and deletes 'a', and side 2 copies 'a' to 'c'
                # and 'd' and deletes 'a'.
                if dsts1 & dsts2:
                    for dst in dsts1 & dsts2:
                        copy1[dst] = src
                        copy2[dst] = src
                else:
                    diverge[src] = sorted(dsts1 | dsts2)
            elif src in m1 and src in m2:
                # copied on both sides
                dsts1 = set(dsts1)
                dsts2 = set(dsts2)
                for dst in dsts1 & dsts2:
                    copy1[dst] = src
                    copy2[dst] = src
            # TODO: Handle cases where it was renamed on one side and copied
            # on the other side
        elif dsts1:
            # copied/renamed only on side 1
            _checksinglesidecopies(
                src, dsts1, m1, m2, mb, c2, base, copy1, renamedelete1
            )
        elif dsts2:
            # copied/renamed only on side 2
            _checksinglesidecopies(
                src, dsts2, m2, m1, mb, c1, base, copy2, renamedelete2
            )

    # find interesting file sets from manifests
    addedinm1 = m1.filesnotin(mb, repo.narrowmatch())
    addedinm2 = m2.filesnotin(mb, repo.narrowmatch())
    u1 = sorted(addedinm1 - addedinm2)
    u2 = sorted(addedinm2 - addedinm1)

    header = b"  unmatched files in %s"
    if u1:
        repo.ui.debug(b"%s:\n   %s\n" % (header % b'local', b"\n   ".join(u1)))
    if u2:
        repo.ui.debug(b"%s:\n   %s\n" % (header % b'other', b"\n   ".join(u2)))

    if repo.ui.debugflag:
        renamedeleteset = set()
        divergeset = set()
        for dsts in diverge.values():
            divergeset.update(dsts)
        for dsts in renamedelete1.values():
            renamedeleteset.update(dsts)
        for dsts in renamedelete2.values():
            renamedeleteset.update(dsts)

        repo.ui.debug(
            b"  all copies found (* = to merge, ! = divergent, "
            b"% = renamed and deleted):\n"
        )
        for side, copies in ((b"local", copies1), (b"remote", copies2)):
            if not copies:
                continue
            repo.ui.debug(b"   on %s side:\n" % side)
            for f in sorted(copies):
                note = b""
                if f in copy1 or f in copy2:
                    note += b"*"
                if f in divergeset:
                    note += b"!"
                if f in renamedeleteset:
                    note += b"%"
                repo.ui.debug(
                    b"    src: '%s' -> dst: '%s' %s\n" % (copies[f], f, note)
                )
        del renamedeleteset
        del divergeset

    repo.ui.debug(b"  checking for directory renames\n")

    dirmove1, movewithdir2 = _dir_renames(repo, c1, copy1, copies1, u2)
    dirmove2, movewithdir1 = _dir_renames(repo, c2, copy2, copies2, u1)

    branch_copies1 = branch_copies(copy1, renamedelete1, dirmove1, movewithdir1)
    branch_copies2 = branch_copies(copy2, renamedelete2, dirmove2, movewithdir2)

    return branch_copies1, branch_copies2, diverge


def _dir_renames(repo, ctx, copy, fullcopy, addedfiles):
    """Finds moved directories and files that should move with them.

    ctx: the context for one of the sides
    copy: files copied on the same side (as ctx)
    fullcopy: files copied on the same side (as ctx), including those that
              merge.manifestmerge() won't care about
    addedfiles: added files on the other side (compared to ctx)
    """
    # generate a directory move map
    d = ctx.dirs()
    invalid = set()
    dirmove = {}

    # examine each file copy for a potential directory move, which is
    # when all the files in a directory are moved to a new directory
    for dst, src in pycompat.iteritems(fullcopy):
        dsrc, ddst = pathutil.dirname(src), pathutil.dirname(dst)
        if dsrc in invalid:
            # already seen to be uninteresting
            continue
        elif dsrc in d and ddst in d:
            # directory wasn't entirely moved locally
            invalid.add(dsrc)
        elif dsrc in dirmove and dirmove[dsrc] != ddst:
            # files from the same directory moved to two different places
            invalid.add(dsrc)
        else:
            # looks good so far
            dirmove[dsrc] = ddst

    for i in invalid:
        if i in dirmove:
            del dirmove[i]
    del d, invalid

    if not dirmove:
        return {}, {}

    dirmove = {k + b"/": v + b"/" for k, v in pycompat.iteritems(dirmove)}

    for d in dirmove:
        repo.ui.debug(
            b"   discovered dir src: '%s' -> dst: '%s'\n" % (d, dirmove[d])
        )

    movewithdir = {}
    # check unaccounted nonoverlapping files against directory moves
    for f in addedfiles:
        if f not in fullcopy:
            for d in dirmove:
                if f.startswith(d):
                    # new file added in a directory that was moved, move it
                    df = dirmove[d] + f[len(d) :]
                    if df not in copy:
                        movewithdir[f] = df
                        repo.ui.debug(
                            b"   pending file src: '%s' -> dst: '%s'\n"
                            % (f, df)
                        )
                    break

    return dirmove, movewithdir


def _heuristicscopytracing(repo, c1, c2, base):
    """ Fast copytracing using filename heuristics

    Assumes that moves or renames are of following two types:

    1) Inside a directory only (same directory name but different filenames)
    2) Move from one directory to another
                    (same filenames but different directory names)

    Works only when there are no merge commits in the "source branch".
    Source branch is commits from base up to c2 not including base.

    If merge is involved it fallbacks to _fullcopytracing().

    Can be used by setting the following config:

        [experimental]
        copytrace = heuristics

    In some cases the copy/move candidates found by heuristics can be very large
    in number and that will make the algorithm slow. The number of possible
    candidates to check can be limited by using the config
    `experimental.copytrace.movecandidateslimit` which defaults to 100.
    """

    if c1.rev() is None:
        c1 = c1.p1()
    if c2.rev() is None:
        c2 = c2.p1()

    changedfiles = set()
    m1 = c1.manifest()
    if not repo.revs(b'%d::%d', base.rev(), c2.rev()):
        # If base is not in c2 branch, we switch to fullcopytracing
        repo.ui.debug(
            b"switching to full copytracing as base is not "
            b"an ancestor of c2\n"
        )
        return _fullcopytracing(repo, c1, c2, base)

    ctx = c2
    while ctx != base:
        if len(ctx.parents()) == 2:
            # To keep things simple let's not handle merges
            repo.ui.debug(b"switching to full copytracing because of merges\n")
            return _fullcopytracing(repo, c1, c2, base)
        changedfiles.update(ctx.files())
        ctx = ctx.p1()

    copies2 = {}
    cp = _forwardcopies(base, c2)
    for dst, src in pycompat.iteritems(cp):
        if src in m1:
            copies2[dst] = src

    # file is missing if it isn't present in the destination, but is present in
    # the base and present in the source.
    # Presence in the base is important to exclude added files, presence in the
    # source is important to exclude removed files.
    filt = lambda f: f not in m1 and f in base and f in c2
    missingfiles = [f for f in changedfiles if filt(f)]

    copies1 = {}
    if missingfiles:
        basenametofilename = collections.defaultdict(list)
        dirnametofilename = collections.defaultdict(list)

        for f in m1.filesnotin(base.manifest()):
            basename = os.path.basename(f)
            dirname = os.path.dirname(f)
            basenametofilename[basename].append(f)
            dirnametofilename[dirname].append(f)

        for f in missingfiles:
            basename = os.path.basename(f)
            dirname = os.path.dirname(f)
            samebasename = basenametofilename[basename]
            samedirname = dirnametofilename[dirname]
            movecandidates = samebasename + samedirname
            # f is guaranteed to be present in c2, that's why
            # c2.filectx(f) won't fail
            f2 = c2.filectx(f)
            # we can have a lot of candidates which can slow down the heuristics
            # config value to limit the number of candidates moves to check
            maxcandidates = repo.ui.configint(
                b'experimental', b'copytrace.movecandidateslimit'
            )

            if len(movecandidates) > maxcandidates:
                repo.ui.status(
                    _(
                        b"skipping copytracing for '%s', more "
                        b"candidates than the limit: %d\n"
                    )
                    % (f, len(movecandidates))
                )
                continue

            for candidate in movecandidates:
                f1 = c1.filectx(candidate)
                if _related(f1, f2):
                    # if there are a few related copies then we'll merge
                    # changes into all of them. This matches the behaviour
                    # of upstream copytracing
                    copies1[candidate] = f

    return branch_copies(copies1), branch_copies(copies2), {}


def _related(f1, f2):
    """return True if f1 and f2 filectx have a common ancestor

    Walk back to common ancestor to see if the two files originate
    from the same file. Since workingfilectx's rev() is None it messes
    up the integer comparison logic, hence the pre-step check for
    None (f1 and f2 can only be workingfilectx's initially).
    """

    if f1 == f2:
        return True  # a match

    g1, g2 = f1.ancestors(), f2.ancestors()
    try:
        f1r, f2r = f1.linkrev(), f2.linkrev()

        if f1r is None:
            f1 = next(g1)
        if f2r is None:
            f2 = next(g2)

        while True:
            f1r, f2r = f1.linkrev(), f2.linkrev()
            if f1r > f2r:
                f1 = next(g1)
            elif f2r > f1r:
                f2 = next(g2)
            else:  # f1 and f2 point to files in the same linkrev
                return f1 == f2  # true if they point to the same file
    except StopIteration:
        return False


def graftcopies(wctx, ctx, base):
    """reproduce copies between base and ctx in the wctx

    Unlike mergecopies(), this function will only consider copies between base
    and ctx; it will ignore copies between base and wctx. Also unlike
    mergecopies(), this function will apply copies to the working copy (instead
    of just returning information about the copies). That makes it cheaper
    (especially in the common case of base==ctx.p1()) and useful also when
    experimental.copytrace=off.

    merge.update() will have already marked most copies, but it will only
    mark copies if it thinks the source files are related (see
    merge._related()). It will also not mark copies if the file wasn't modified
    on the local side. This function adds the copies that were "missed"
    by merge.update().
    """
    new_copies = pathcopies(base, ctx)
    _filter(wctx.p1(), wctx, new_copies)
    for dst, src in pycompat.iteritems(new_copies):
        wctx[dst].markcopied(src)
