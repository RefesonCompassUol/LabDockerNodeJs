# config.py - configuration parsing for Mercurial
#
#  Copyright 2009 Matt Mackall <mpm@selenic.com> and others
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2 or any later version.

from __future__ import absolute_import

import errno
import os

from .i18n import _
from .pycompat import getattr
from . import (
    encoding,
    error,
    pycompat,
    util,
)


class config(object):
    def __init__(self, data=None):
        self._data = {}
        self._unset = []
        if data:
            for k in data._data:
                self._data[k] = data[k].copy()
            self._source = data._source.copy()
        else:
            self._source = util.cowdict()

    def copy(self):
        return config(self)

    def __contains__(self, section):
        return section in self._data

    def hasitem(self, section, item):
        return item in self._data.get(section, {})

    def __getitem__(self, section):
        return self._data.get(section, {})

    def __iter__(self):
        for d in self.sections():
            yield d

    def update(self, src):
        self._source = self._source.preparewrite()
        for s, n in src._unset:
            ds = self._data.get(s, None)
            if ds is not None and n in ds:
                self._data[s] = ds.preparewrite()
                del self._data[s][n]
                del self._source[(s, n)]
        for s in src:
            ds = self._data.get(s, None)
            if ds:
                self._data[s] = ds.preparewrite()
            else:
                self._data[s] = util.cowsortdict()
            self._data[s].update(src._data[s])
        self._source.update(src._source)

    def get(self, section, item, default=None):
        return self._data.get(section, {}).get(item, default)

    def backup(self, section, item):
        """return a tuple allowing restore to reinstall a previous value

        The main reason we need it is because it handles the "no data" case.
        """
        try:
            value = self._data[section][item]
            source = self.source(section, item)
            return (section, item, value, source)
        except KeyError:
            return (section, item)

    def source(self, section, item):
        return self._source.get((section, item), b"")

    def sections(self):
        return sorted(self._data.keys())

    def items(self, section):
        return list(pycompat.iteritems(self._data.get(section, {})))

    def set(self, section, item, value, source=b""):
        if pycompat.ispy3:
            assert not isinstance(
                section, str
            ), b'config section may not be unicode strings on Python 3'
            assert not isinstance(
                item, str
            ), b'config item may not be unicode strings on Python 3'
            assert not isinstance(
                value, str
            ), b'config values may not be unicode strings on Python 3'
        if section not in self:
            self._data[section] = util.cowsortdict()
        else:
            self._data[section] = self._data[section].preparewrite()
        self._data[section][item] = value
        if source:
            self._source = self._source.preparewrite()
            self._source[(section, item)] = source

    def restore(self, data):
        """restore data returned by self.backup"""
        self._source = self._source.preparewrite()
        if len(data) == 4:
            # restore old data
            section, item, value, source = data
            self._data[section] = self._data[section].preparewrite()
            self._data[section][item] = value
            self._source[(section, item)] = source
        else:
            # no data before, remove everything
            section, item = data
            if section in self._data:
                self._data[section].pop(item, None)
            self._source.pop((section, item), None)

    def parse(self, src, data, sections=None, remap=None, include=None):
        sectionre = util.re.compile(br'\[([^\[]+)\]')
        itemre = util.re.compile(br'([^=\s][^=]*?)\s*=\s*(.*\S|)')
        contre = util.re.compile(br'\s+(\S|\S.*\S)\s*$')
        emptyre = util.re.compile(br'(;|#|\s*$)')
        commentre = util.re.compile(br'(;|#)')
        unsetre = util.re.compile(br'%unset\s+(\S+)')
        includere = util.re.compile(br'%include\s+(\S|\S.*\S)\s*$')
        section = b""
        item = None
        line = 0
        cont = False

        if remap:
            section = remap.get(section, section)

        for l in data.splitlines(True):
            line += 1
            if line == 1 and l.startswith(b'\xef\xbb\xbf'):
                # Someone set us up the BOM
                l = l[3:]
            if cont:
                if commentre.match(l):
                    continue
                m = contre.match(l)
                if m:
                    if sections and section not in sections:
                        continue
                    v = self.get(section, item) + b"\n" + m.group(1)
                    self.set(section, item, v, b"%s:%d" % (src, line))
                    continue
                item = None
                cont = False
            m = includere.match(l)

            if m and include:
                expanded = util.expandpath(m.group(1))
                try:
                    include(expanded, remap=remap, sections=sections)
                except IOError as inst:
                    if inst.errno != errno.ENOENT:
                        raise error.ParseError(
                            _(b"cannot include %s (%s)")
                            % (expanded, encoding.strtolocal(inst.strerror)),
                            b"%s:%d" % (src, line),
                        )
                continue
            if emptyre.match(l):
                continue
            m = sectionre.match(l)
            if m:
                section = m.group(1)
                if remap:
                    section = remap.get(section, section)
                if section not in self:
                    self._data[section] = util.cowsortdict()
                continue
            m = itemre.match(l)
            if m:
                item = m.group(1)
                cont = True
                if sections and section not in sections:
                    continue
                self.set(section, item, m.group(2), b"%s:%d" % (src, line))
                continue
            m = unsetre.match(l)
            if m:
                name = m.group(1)
                if sections and section not in sections:
                    continue
                if self.get(section, name) is not None:
                    self._data[section] = self._data[section].preparewrite()
                    del self._data[section][name]
                self._unset.append((section, name))
                continue

            raise error.ParseError(l.rstrip(), (b"%s:%d" % (src, line)))

    def read(self, path, fp=None, sections=None, remap=None):
        if not fp:
            fp = util.posixfile(path, b'rb')
        assert getattr(fp, 'mode', 'rb') == 'rb', (
            b'config files must be opened in binary mode, got fp=%r mode=%r'
            % (fp, fp.mode,)
        )

        dir = os.path.dirname(path)

        def include(rel, remap, sections):
            abs = os.path.normpath(os.path.join(dir, rel))
            self.read(abs, remap=remap, sections=sections)

        self.parse(
            path, fp.read(), sections=sections, remap=remap, include=include
        )


def parselist(value):
    """parse a configuration value as a list of comma/space separated strings

    >>> parselist(b'this,is "a small" ,test')
    ['this', 'is', 'a small', 'test']
    """

    def _parse_plain(parts, s, offset):
        whitespace = False
        while offset < len(s) and (
            s[offset : offset + 1].isspace() or s[offset : offset + 1] == b','
        ):
            whitespace = True
            offset += 1
        if offset >= len(s):
            return None, parts, offset
        if whitespace:
            parts.append(b'')
        if s[offset : offset + 1] == b'"' and not parts[-1]:
            return _parse_quote, parts, offset + 1
        elif s[offset : offset + 1] == b'"' and parts[-1][-1:] == b'\\':
            parts[-1] = parts[-1][:-1] + s[offset : offset + 1]
            return _parse_plain, parts, offset + 1
        parts[-1] += s[offset : offset + 1]
        return _parse_plain, parts, offset + 1

    def _parse_quote(parts, s, offset):
        if offset < len(s) and s[offset : offset + 1] == b'"':  # ""
            parts.append(b'')
            offset += 1
            while offset < len(s) and (
                s[offset : offset + 1].isspace()
                or s[offset : offset + 1] == b','
            ):
                offset += 1
            return _parse_plain, parts, offset

        while offset < len(s) and s[offset : offset + 1] != b'"':
            if (
                s[offset : offset + 1] == b'\\'
                and offset + 1 < len(s)
                and s[offset + 1 : offset + 2] == b'"'
            ):
                offset += 1
                parts[-1] += b'"'
            else:
                parts[-1] += s[offset : offset + 1]
            offset += 1

        if offset >= len(s):
            real_parts = _configlist(parts[-1])
            if not real_parts:
                parts[-1] = b'"'
            else:
                real_parts[0] = b'"' + real_parts[0]
                parts = parts[:-1]
                parts.extend(real_parts)
            return None, parts, offset

        offset += 1
        while offset < len(s) and s[offset : offset + 1] in [b' ', b',']:
            offset += 1

        if offset < len(s):
            if offset + 1 == len(s) and s[offset : offset + 1] == b'"':
                parts[-1] += b'"'
                offset += 1
            else:
                parts.append(b'')
        else:
            return None, parts, offset

        return _parse_plain, parts, offset

    def _configlist(s):
        s = s.rstrip(b' ,')
        if not s:
            return []
        parser, parts, offset = _parse_plain, [b''], 0
        while parser:
            parser, parts, offset = parser(parts, s, offset)
        return parts

    if value is not None and isinstance(value, bytes):
        result = _configlist(value.lstrip(b' ,\n'))
    else:
        result = value
    return result or []
