package Fcntl;

use strict;
our($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

require Exporter;
require XSLoader;
@ISA = qw(Exporter);
$VERSION = '1.13';

XSLoader::load();

# Named groups of exports
%EXPORT_TAGS = (
    'flock'   => [qw(LOCK_SH LOCK_EX LOCK_NB LOCK_UN)],
    'Fcompat' => [qw(FAPPEND FASYNC FCREAT FDEFER FDSYNC FEXCL FLARGEFILE
		     FNDELAY FNONBLOCK FRSYNC FSYNC FTRUNC)],
    'seek'    => [qw(SEEK_SET SEEK_CUR SEEK_END)],
    'mode'    => [qw(S_ISUID S_ISGID S_ISVTX S_ISTXT
		     _S_IFMT S_IFREG S_IFDIR S_IFLNK
		     S_IFSOCK S_IFBLK S_IFCHR S_IFIFO S_IFWHT S_ENFMT
		     S_IRUSR S_IWUSR S_IXUSR S_IRWXU
		     S_IRGRP S_IWGRP S_IXGRP S_IRWXG
		     S_IROTH S_IWOTH S_IXOTH S_IRWXO
		     S_IREAD S_IWRITE S_IEXEC
		     S_ISREG S_ISDIR S_ISLNK S_ISSOCK
		     S_ISBLK S_ISCHR S_ISFIFO
		     S_ISWHT S_ISENFMT		
		     S_IFMT S_IMODE
                  )],
);

# Items to export into callers namespace by default
# (move infrequently used names to @EXPORT_OK below)
@EXPORT =
  qw(
	FD_CLOEXEC
	F_ALLOCSP
	F_ALLOCSP64
	F_COMPAT
	F_DUP2FD
	F_DUPFD
	F_EXLCK
	F_FREESP
	F_FREESP64
	F_FSYNC
	F_FSYNC64
	F_GETFD
	F_GETFL
	F_GETLK
	F_GETLK64
	F_GETOWN
	F_NODNY
	F_POSIX
	F_RDACC
	F_RDDNY
	F_RDLCK
	F_RWACC
	F_RWDNY
	F_SETFD
	F_SETFL
	F_SETLK
	F_SETLK64
	F_SETLKW
	F_SETLKW64
	F_SETOWN
	F_SHARE
	F_SHLCK
	F_UNLCK
	F_UNSHARE
	F_WRACC
	F_WRDNY
	F_WRLCK
	O_ACCMODE
	O_ALIAS
	O_APPEND
	O_ASYNC
	O_BINARY
	O_CREAT
	O_DEFER
	O_DIRECT
	O_DIRECTORY
	O_DSYNC
	O_EXCL
	O_EXLOCK
	O_LARGEFILE
	O_NDELAY
	O_NOCTTY
	O_NOFOLLOW
	O_NOINHERIT
	O_NONBLOCK
	O_RANDOM
	O_RAW
	O_RDONLY
	O_RDWR
	O_RSRC
	O_RSYNC
	O_SEQUENTIAL
	O_SHLOCK
	O_SYNC
	O_TEMPORARY
	O_TEXT
	O_TRUNC
	O_WRONLY
     );

# Other items we are prepared to export if requested
@EXPORT_OK = (qw(
	DN_ACCESS
	DN_ATTRIB
	DN_CREATE
	DN_DELETE
	DN_MODIFY
	DN_MULTISHOT
	DN_RENAME
	F_GETLEASE
	F_GETPIPE_SZ
	F_GETSIG
	F_NOTIFY
	F_SETLEASE
	F_SETPIPE_SZ
	F_SETSIG
	LOCK_MAND
	LOCK_READ
	LOCK_RW
	LOCK_WRITE
        O_ALT_IO
        O_EVTONLY
	O_IGNORE_CTTY
	O_NOATIME
	O_NOLINK
        O_NOSIGPIPE
	O_NOTRANS
        O_SYMLINK
        O_TTY_INIT
), map {@{$_}} values %EXPORT_TAGS);

1;