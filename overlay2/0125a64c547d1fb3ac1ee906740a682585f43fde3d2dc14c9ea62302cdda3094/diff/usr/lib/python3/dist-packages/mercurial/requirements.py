# requirements.py - objects and functions related to repository requirements
#
# Copyright 2005-2007 Matt Mackall <mpm@selenic.com>
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2 or any later version.

from __future__ import absolute_import

# When narrowing is finalized and no longer subject to format changes,
# we should move this to just "narrow" or similar.
NARROW_REQUIREMENT = b'narrowhg-experimental'

# Enables sparse working directory usage
SPARSE_REQUIREMENT = b'exp-sparse'

# Enables the internal phase which is used to hide changesets instead
# of stripping them
INTERNAL_PHASE_REQUIREMENT = b'internal-phase'

# Stores manifest in Tree structure
TREEMANIFEST_REQUIREMENT = b'treemanifest'

# Increment the sub-version when the revlog v2 format changes to lock out old
# clients.
REVLOGV2_REQUIREMENT = b'exp-revlogv2.1'

# A repository with the sparserevlog feature will have delta chains that
# can spread over a larger span. Sparse reading cuts these large spans into
# pieces, so that each piece isn't too big.
# Without the sparserevlog capability, reading from the repository could use
# huge amounts of memory, because the whole span would be read at once,
# including all the intermediate revisions that aren't pertinent for the chain.
# This is why once a repository has enabled sparse-read, it becomes required.
SPARSEREVLOG_REQUIREMENT = b'sparserevlog'

# A repository with the sidedataflag requirement will allow to store extra
# information for revision without altering their original hashes.
SIDEDATA_REQUIREMENT = b'exp-sidedata-flag'

# A repository with the the copies-sidedata-changeset requirement will store
# copies related information in changeset's sidedata.
COPIESSDC_REQUIREMENT = b'exp-copies-sidedata-changeset'

# The repository use persistent nodemap for the changelog and the manifest.
NODEMAP_REQUIREMENT = b'persistent-nodemap'

# Denotes that the current repository is a share
SHARED_REQUIREMENT = b'shared'

# Denotes that current repository is a share and the shared source path is
# relative to the current repository root path
RELATIVE_SHARED_REQUIREMENT = b'relshared'

# A repository with share implemented safely. The repository has different
# store and working copy requirements i.e. both `.hg/requires` and
# `.hg/store/requires` are present.
SHARESAFE_REQUIREMENT = b'exp-sharesafe'

# List of requirements which are working directory specific
# These requirements cannot be shared between repositories if they
# share the same store
# * sparse is a working directory specific functionality and hence working
#   directory specific requirement
# * SHARED_REQUIREMENT and RELATIVE_SHARED_REQUIREMENT are requirements which
#   represents that the current working copy/repository shares store of another
#   repo. Hence both of them should be stored in working copy
# * SHARESAFE_REQUIREMENT needs to be stored in working dir to mark that rest of
#   the requirements are stored in store's requires
WORKING_DIR_REQUIREMENTS = {
    SPARSE_REQUIREMENT,
    SHARED_REQUIREMENT,
    RELATIVE_SHARED_REQUIREMENT,
    SHARESAFE_REQUIREMENT,
}
