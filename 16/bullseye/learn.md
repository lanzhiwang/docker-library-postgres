```bash
$ docker pull debian:bullseye-slim

$ docker run -ti --rm \
-v ~/work/code/py_code/postgres/docker-library-postgres:/docker-library-postgres \
debian:bullseye-slim bash



root@41eff97a5765:/# pwd
/
root@41eff97a5765:/#

root@41eff97a5765:/#
root@41eff97a5765:/#
root@41eff97a5765:/# groupadd -r postgres --gid=999
root@41eff97a5765:/# useradd -r -g postgres --uid=999 --home-dir=/var/lib/postgresql --shell=/bin/bash postgres
root@41eff97a5765:/# install --verbose --directory --owner postgres --group postgres --mode 1777 /var/lib/postgresql
install: creating directory '/var/lib/postgresql'
root@41eff97a5765:/#
root@41eff97a5765:/#
root@41eff97a5765:/# apt-get update
root@41eff97a5765:/# apt-get install -y --no-install-recommends gnupg less
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  dirmngr gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server gpgconf gpgsm libassuan0 libksba8 libldap-2.4-2 libncursesw6 libnpth0 libreadline8 libsasl2-2
  libsasl2-modules-db libsqlite3-0 pinentry-curses readline-common
Suggested packages:
  dbus-user-session libpam-systemd pinentry-gnome3 tor parcimonie xloadimage scdaemon pinentry-doc readline-doc
Recommended packages:
  libldap-common libgpm2 libsasl2-modules
The following NEW packages will be installed:
  dirmngr gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server gpgconf gpgsm less libassuan0 libksba8 libldap-2.4-2 libncursesw6 libnpth0 libreadline8 libsasl2-2
  libsasl2-modules-db libsqlite3-0 pinentry-curses readline-common
0 upgraded, 22 newly installed, 0 to remove and 2 not upgraded.
root@41eff97a5765:/# rm -rf /var/lib/apt/lists/*
root@41eff97a5765:/#

dirmngr
gnupg-l10n
gnupg-utils
gpg
gpg-agent
gpg-wks-client
gpg-wks-server
gpgconf
gpgsm
libassuan0
libksba8
libldap-2.4-2
libncursesw6
libnpth0
libreadline8
libsasl2-2
libsasl2-modules-db
libsqlite3-0
pinentry-curses
readline-common
dbus-user-session
libpam-systemd
pinentry-gnome3
tor
parcimonie
xloadimage
scdaemon
pinentry-doc
readline-doc
libldap-common
libgpm2
libsasl2-modules
gnupg
less

root@41eff97a5765:/# savedAptMark="$(apt-mark showmanual)"
root@41eff97a5765:/# echo ${savedAptMark}
gnupg less
root@41eff97a5765:/# apt-get update
root@41eff97a5765:/# apt-get install -y --no-install-recommends ca-certificates wget
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libpsl5 openssl
Recommended packages:
  publicsuffix
The following NEW packages will be installed:
  ca-certificates libpsl5 openssl wget
0 upgraded, 4 newly installed, 0 to remove and 2 not upgraded.

libpsl5
openssl
publicsuffix
ca-certificates
wget

root@41eff97a5765:/# rm -rf /var/lib/apt/lists/*
root@41eff97a5765:/# dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"
root@41eff97a5765:/# echo ${dpkgArch}
amd64
root@41eff97a5765:/#
root@41eff97a5765:/# wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.17/gosu-$dpkgArch"
--2025-07-31 09:26:29--  https://github.com/tianon/gosu/releases/download/1.17/gosu-amd64
2025-07-31 09:26:30 (36.2 MB/s) - '/usr/local/bin/gosu' saved [2355481/2355481]

root@41eff97a5765:/# ls -al /usr/local/bin/gosu
-rw-r--r-- 1 root root 2355481 Nov  2  2023 /usr/local/bin/gosu
root@41eff97a5765:/#
root@41eff97a5765:/# wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.17/gosu-$dpkgArch.asc"
--2025-07-31 09:27:46--  https://github.com/tianon/gosu/releases/download/1.17/gosu-amd64.asc
2025-07-31 09:27:47 (34.8 MB/s) - '/usr/local/bin/gosu.asc' saved [566/566]

root@41eff97a5765:/# ls -al /usr/local/bin/gosu.asc
-rw-r--r-- 1 root root 566 Nov  2  2023 /usr/local/bin/gosu.asc
root@41eff97a5765:/#
root@41eff97a5765:/# export GNUPGHOME="$(mktemp -d)"
root@41eff97a5765:/# echo ${GNUPGHOME}
/tmp/tmp.3sulRASblL
root@41eff97a5765:/#
root@41eff97a5765:/# gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
gpg: keybox '/tmp/tmp.3sulRASblL/pubring.kbx' created
gpg: /tmp/tmp.3sulRASblL/trustdb.gpg: trustdb created
gpg: key 036A9C25BF357DD4: public key "Tianon Gravi <tianon@tianon.xyz>" imported
gpg: Total number processed: 1
gpg:               imported: 1
root@41eff97a5765:/#
root@41eff97a5765:/# ls -al ${GNUPGHOME}
total 48
drwx------ 4 root root  4096 Jul 31 09:29 .
drwxrwxrwt 1 root root  4096 Jul 31 09:28 ..
srwx------ 1 root root     0 Jul 31 09:29 S.dirmngr
srwx------ 1 root root     0 Jul 31 09:29 S.gpg-agent
srwx------ 1 root root     0 Jul 31 09:29 S.gpg-agent.browser
srwx------ 1 root root     0 Jul 31 09:29 S.gpg-agent.extra
srwx------ 1 root root     0 Jul 31 09:29 S.gpg-agent.ssh
drwx------ 2 root root  4096 Jul 31 09:29 crls.d
drwx------ 2 root root  4096 Jul 31 09:29 private-keys-v1.d
-rw-r--r-- 1 root root 23067 Jul 31 09:29 pubring.kbx
-rw------- 1 root root    32 Jul 31 09:29 pubring.kbx~
-rw------- 1 root root  1200 Jul 31 09:29 trustdb.gpg
root@41eff97a5765:/#
root@41eff97a5765:/# gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu
gpg: Signature made Thu Nov  2 21:37:18 2023 UTC
gpg:                using RSA key B42F6819007F00F88E364FD4036A9C25BF357DD4
gpg: Good signature from "Tianon Gravi <tianon@tianon.xyz>" [unknown]
gpg:                 aka "Andrew Page (Tianon Gravi) <admwiggin@gmail.com>" [unknown]
gpg:                 aka "Tianon Gravi (Andrew Page) <tianon@infosiftr.com>" [unknown]
gpg:                 aka "Tianon Gravi <tianon@debian.org>" [unknown]
gpg:                 aka "Tianon Gravi <tianon@dockerproject.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: B42F 6819 007F 00F8 8E36  4FD4 036A 9C25 BF35 7DD4
root@41eff97a5765:/#
root@41eff97a5765:/# gpgconf --kill all
root@41eff97a5765:/# rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc
root@41eff97a5765:/# apt-mark auto '.*' > /dev/null
root@41eff97a5765:/# [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null
root@41eff97a5765:/# apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false
root@41eff97a5765:/# chmod +x /usr/local/bin/gosu
root@41eff97a5765:/# gosu --version
1.17 (go1.18.2 on linux/amd64; gc)
root@41eff97a5765:/# gosu nobody true
root@41eff97a5765:/#

root@41eff97a5765:/# ls -al /etc/dpkg/dpkg.cfg.d/docker
-rw-r--r-- 1 root root 3846 Jul 21 00:00 /etc/dpkg/dpkg.cfg.d/docker
root@41eff97a5765:/# cat /etc/dpkg/dpkg.cfg.d/docker
# This is the "slim" variant of the Debian base image.
# Many files which are normally unnecessary in containers are excluded,
# and this configuration file keeps them that way.

# dpkg -S '/usr/share/doc/*'
#  adduser apt base-files base-passwd bash bsdutils coreutils dash debconf
#  debian-archive-keyring debianutils diffutils dpkg e2fsprogs findutils
#  gcc-10-base:amd64 gcc-9-base:amd64 gpgv grep gzip hostname
#  init-system-helpers libacl1:amd64 libapt-pkg6.0:amd64 libattr1:amd64
#  libaudit-common libaudit1:amd64 libblkid1:amd64 libbz2-1.0:amd64 libc-bin
#  libc6:amd64 libcap-ng0:amd64 libcom-err2:amd64 libcrypt1:amd64
#  libdb5.3:amd64 libdebconfclient0:amd64 libext2fs2:amd64 libffi7:amd64
#  libgcc-s1:amd64 libgcrypt20:amd64 libgmp10:amd64 libgnutls30:amd64
#  libgpg-error0:amd64 libgssapi-krb5-2:amd64 libhogweed6:amd64
#  libidn2-0:amd64 libk5crypto3:amd64 libkeyutils1:amd64 libkrb5-3:amd64
#  libkrb5support0:amd64 liblz4-1:amd64 liblzma5:amd64 libmount1:amd64
#  libnettle8:amd64 libnsl2:amd64 libp11-kit0:amd64 libpam-modules-bin
#  libpam-modules:amd64 libpam-runtime libpam0g:amd64 libpcre2-8-0:amd64
#  libpcre3:amd64 libseccomp2:amd64 libselinux1:amd64 libsemanage-common
#  libsemanage1:amd64 libsepol1:amd64 libsmartcols1:amd64 libss2:amd64
#  libssl1.1:amd64 libstdc++6:amd64 libsystemd0:amd64 libtasn1-6:amd64
#  libtinfo6:amd64 libtirpc-common libtirpc3:amd64 libudev1:amd64
#  libunistring2:amd64 libuuid1:amd64 libxxhash0:amd64 libzstd1:amd64 login
#  logsave lsb-base mawk mount ncurses-base ncurses-bin passwd perl-base sed
#  sysvinit-utils tar tzdata util-linux zlib1g:amd64
path-exclude /usr/share/doc/*

# dpkg -S '/usr/share/doc/kde/HTML/*/*'
#  dpkg-query: no path found matching pattern /usr/share/doc/kde/HTML/*/*
path-exclude /usr/share/doc/kde/HTML/*/*

# dpkg -S '/usr/share/gnome/help/*/*'
#  dpkg-query: no path found matching pattern /usr/share/gnome/help/*/*
path-exclude /usr/share/gnome/help/*/*

# dpkg -S '/usr/share/info/*'
#  coreutils diffutils findutils grep gzip sed
path-exclude /usr/share/info/*

# dpkg -S '/usr/share/linda/*'
#  dpkg-query: no path found matching pattern /usr/share/linda/*
path-exclude /usr/share/linda/*

# dpkg -S '/usr/share/lintian/overrides/*'
#  apt base-files base-passwd bash bsdutils dash debconf dpkg e2fsprogs
#  libc-bin libc6:amd64 libdb5.3:amd64 libgcc-s1:amd64 libgssapi-krb5-2:amd64
#  libidn2-0:amd64 libkrb5-3:amd64 libpam-modules-bin libpam-modules:amd64
#  libpam-runtime libpam0g:amd64 login mount ncurses-base passwd perl-base
#  util-linux
path-exclude /usr/share/lintian/overrides/*

# dpkg -S '/usr/share/locale/*'
#  adduser apt bash coreutils diffutils dpkg findutils grep
#  libapt-pkg6.0:amd64 libgnutls30:amd64 libidn2-0:amd64 libpam-runtime login
#  sed tar
path-exclude /usr/share/locale/*

# dpkg -S '/usr/share/man/*'
#  adduser apt base-passwd bash bsdutils coreutils dash debconf debianutils
#  diffutils diversion by dash from diversion by dash to dpkg e2fsprogs
#  findutils gpgv grep gzip hostname init-system-helpers libaudit-common
#  libc-bin libpam-modules-bin libpam-modules:amd64 libpam-runtime
#  libpcre3:amd64 libsemanage-common libtirpc-common login logsave mawk mount
#  ncurses-bin passwd perl-base sed sysvinit-utils tar util-linux
path-exclude /usr/share/man/*

# dpkg -S '/usr/share/omf/*/*-*.emf'
#  dpkg-query: no path found matching pattern /usr/share/omf/*/*-*.emf
path-exclude /usr/share/omf/*/*-*.emf

path-include /usr/share/doc/*/copyright
path-include /usr/share/doc/kde/HTML/C/*
path-include /usr/share/gnome/help/*/C/*
path-include /usr/share/locale/all_languages
path-include /usr/share/locale/currency/*
path-include /usr/share/locale/l10n/*
path-include /usr/share/locale/languages
path-include /usr/share/locale/locale.alias
path-include /usr/share/omf/*/*-C.emf
root@41eff97a5765:/#
root@41eff97a5765:/# grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker
root@41eff97a5765:/# sed -ri '/\/usr\/share\/locale/d' /etc/dpkg/dpkg.cfg.d/docker
root@41eff97a5765:/# ! grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker
root@41eff97a5765:/#
root@41eff97a5765:/# apt-get update
root@41eff97a5765:/# apt-get install -y --no-install-recommends locales
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libc-l10n
The following NEW packages will be installed:
  libc-l10n locales
0 upgraded, 2 newly installed, 0 to remove and 2 not upgraded.

libc-l10n
locales

root@41eff97a5765:/#
root@41eff97a5765:/# rm -rf /var/lib/apt/lists/*
root@41eff97a5765:/# echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
root@41eff97a5765:/# locale-gen
Generating locales (this might take a while)...
  en_US.UTF-8... done
Generation complete.
root@41eff97a5765:/# locale -a | grep 'en_US.utf8'
en_US.utf8
root@41eff97a5765:/#


root@41eff97a5765:/# echo ${LANG}

root@41eff97a5765:/# LANG=en_US.utf8
root@41eff97a5765:/# echo ${LANG}
en_US.utf8
root@41eff97a5765:/# export LANG=en_US.utf8
root@41eff97a5765:/# env
HOSTNAME=41eff97a5765
GNUPGHOME=/tmp/tmp.3sulRASblL
PWD=/
HOME=/root
LANG=en_US.utf8
TERM=xterm
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
_=/usr/bin/env
root@41eff97a5765:/#


root@41eff97a5765:/# apt-get update
root@41eff97a5765:/# apt-get install -y --no-install-recommends libnss-wrapper xz-utils zstd
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  libnss-wrapper xz-utils zstd
0 upgraded, 3 newly installed, 0 to remove and 2 not upgraded.

libnss-wrapper
xz-utils
zstd

root@41eff97a5765:/#
root@41eff97a5765:/# rm -rf /var/lib/apt/lists/*
root@41eff97a5765:/#

root@41eff97a5765:/# mkdir /docker-entrypoint-initdb.d
root@41eff97a5765:/# ls -al /docker-entrypoint-initdb.d
total 8
drwxr-xr-x 2 root root 4096 Jul 31 09:41 .
drwxr-xr-x 1 root root 4096 Jul 31 09:41 ..
root@41eff97a5765:/#

root@41eff97a5765:/# key='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8'
root@41eff97a5765:/# echo ${key}
B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
root@41eff97a5765:/# export GNUPGHOME="$(mktemp -d)"
root@41eff97a5765:/# echo ${GNUPGHOME}
/tmp/tmp.eYy2IssOGj
root@41eff97a5765:/# mkdir -p /usr/local/share/keyrings/
root@41eff97a5765:/# ls -al /usr/local/share/keyrings/
total 8
drwxr-xr-x 2 root root 4096 Jul 31 09:43 .
drwxr-xr-x 1 root root 4096 Jul 31 09:43 ..
root@41eff97a5765:/# gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"
gpg: keybox '/tmp/tmp.eYy2IssOGj/pubring.kbx' created
gpg: /tmp/tmp.eYy2IssOGj/trustdb.gpg: trustdb created
gpg: key 7FCC7D46ACCC4CF8: public key "PostgreSQL Debian Repository" imported
gpg: Total number processed: 1
gpg:               imported: 1
root@41eff97a5765:/# gpg --batch --export --armor "$key" > /usr/local/share/keyrings/postgres.gpg.asc
root@41eff97a5765:/# gpgconf --kill all
root@41eff97a5765:/# rm -rf "$GNUPGHOME"
root@41eff97a5765:/#


root@41eff97a5765:/# export PG_MAJOR=16
root@41eff97a5765:/# export PATH=$PATH:/usr/lib/postgresql/$PG_MAJOR/bin
root@41eff97a5765:/# export PG_VERSION=16.9-1.pgdg110+1
root@41eff97a5765:/# env
HOSTNAME=41eff97a5765
GNUPGHOME=/tmp/tmp.eYy2IssOGj
PWD=/
HOME=/root
LANG=en_US.utf8
PG_MAJOR=16
PG_VERSION=16.9-1.pgdg110+1
TERM=xterm
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/16/bin
_=/usr/bin/env
root@41eff97a5765:/#

root@41eff97a5765:/# export PYTHONDONTWRITEBYTECODE=1
root@41eff97a5765:/# dpkgArch="$(dpkg --print-architecture)"
root@41eff97a5765:/# echo ${dpkgArch}
amd64
root@41eff97a5765:/# aptRepo="[ signed-by=/usr/local/share/keyrings/postgres.gpg.asc ] http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main 16"
root@41eff97a5765:/# echo ${aptRepo}
[ signed-by=/usr/local/share/keyrings/postgres.gpg.asc ] http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main 16
root@41eff97a5765:/# echo "deb $aptRepo" > /etc/apt/sources.list.d/pgdg.list
root@41eff97a5765:/# cat /etc/apt/sources.list.d/pgdg.list
deb [ signed-by=/usr/local/share/keyrings/postgres.gpg.asc ] http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main 16
root@41eff97a5765:/# apt-get update
root@41eff97a5765:/#
root@41eff97a5765:/# apt-get install -y --no-install-recommends postgresql-common
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libgdbm-compat4 libgdbm6 libio-pty-perl libipc-run-perl libjson-perl libperl5.32 netbase openssl perl perl-modules-5.32 postgresql-client-common postgresql-common-dev sensible-utils
  ssl-cert ucf
Suggested packages:
  gdbm-l10n ca-certificates perl-doc libterm-readline-gnu-perl | libterm-readline-perl-perl make libtap-harness-archive-perl
Recommended packages:
  libjson-xs-perl logrotate
The following NEW packages will be installed:
  libgdbm-compat4 libgdbm6 libio-pty-perl libipc-run-perl libjson-perl libperl5.32 netbase openssl perl perl-modules-5.32 postgresql-client-common postgresql-common postgresql-common-dev
  sensible-utils ssl-cert ucf
0 upgraded, 16 newly installed, 0 to remove and 2 not upgraded.
Need to get 8,997 kB of archives.
After this operation, 50.9 MB of additional disk space will be used.
Get:1 http://apt.postgresql.org/pub/repos/apt bullseye-pgdg/main amd64 postgresql-client-common all 281.pgdg110+1 [106 kB]
Get:2 http://apt.postgresql.org/pub/repos/apt bullseye-pgdg/main amd64 postgresql-common-dev all 281.pgdg110+1 [132 kB]
Get:3 http://deb.debian.org/debian-security bullseye-security/main amd64 perl-modules-5.32 all 5.32.1-4+deb11u4 [2,824 kB]
Get:4 http://deb.debian.org/debian bullseye/main amd64 libgdbm6 amd64 1.19-2 [64.9 kB]
Get:5 http://apt.postgresql.org/pub/repos/apt bullseye-pgdg/main amd64 postgresql-common all 281.pgdg110+1 [183 kB]
Get:6 http://deb.debian.org/debian bullseye/main amd64 libgdbm-compat4 amd64 1.19-2 [44.7 kB]
Get:7 http://deb.debian.org/debian-security bullseye-security/main amd64 libperl5.32 amd64 5.32.1-4+deb11u4 [4,132 kB]
Get:8 http://deb.debian.org/debian-security bullseye-security/main amd64 perl amd64 5.32.1-4+deb11u4 [293 kB]
Get:9 http://deb.debian.org/debian bullseye/main amd64 libjson-perl all 4.03000-1 [88.6 kB]
Get:10 http://deb.debian.org/debian bullseye/main amd64 netbase all 6.3 [19.9 kB]
Get:11 http://deb.debian.org/debian bullseye/main amd64 libio-pty-perl amd64 1:1.15-2 [37.0 kB]
Get:12 http://deb.debian.org/debian bullseye/main amd64 libipc-run-perl all 20200505.0-1 [102 kB]
Get:13 http://deb.debian.org/debian-security bullseye-security/main amd64 openssl amd64 1.1.1w-0+deb11u3 [859 kB]
Get:14 http://deb.debian.org/debian bullseye/main amd64 ssl-cert all 1.1.0+nmu1 [21.0 kB]
Get:15 http://deb.debian.org/debian bullseye/main amd64 sensible-utils all 0.0.14 [14.8 kB]
Get:16 http://deb.debian.org/debian-security bullseye-security/main amd64 ucf all 3.0043+deb11u2 [74.3 kB]
Fetched 8,997 kB in 3s (2,819 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package perl-modules-5.32.
(Reading database ... 7763 files and directories currently installed.)
Preparing to unpack .../00-perl-modules-5.32_5.32.1-4+deb11u4_all.deb ...
Unpacking perl-modules-5.32 (5.32.1-4+deb11u4) ...
Selecting previously unselected package libgdbm6:amd64.
Preparing to unpack .../01-libgdbm6_1.19-2_amd64.deb ...
Unpacking libgdbm6:amd64 (1.19-2) ...
Selecting previously unselected package libgdbm-compat4:amd64.
Preparing to unpack .../02-libgdbm-compat4_1.19-2_amd64.deb ...
Unpacking libgdbm-compat4:amd64 (1.19-2) ...
Selecting previously unselected package libperl5.32:amd64.
Preparing to unpack .../03-libperl5.32_5.32.1-4+deb11u4_amd64.deb ...
Unpacking libperl5.32:amd64 (5.32.1-4+deb11u4) ...
Selecting previously unselected package perl.
Preparing to unpack .../04-perl_5.32.1-4+deb11u4_amd64.deb ...
Unpacking perl (5.32.1-4+deb11u4) ...
Selecting previously unselected package libjson-perl.
Preparing to unpack .../05-libjson-perl_4.03000-1_all.deb ...
Unpacking libjson-perl (4.03000-1) ...
Selecting previously unselected package netbase.
Preparing to unpack .../06-netbase_6.3_all.deb ...
Unpacking netbase (6.3) ...
Selecting previously unselected package postgresql-client-common.
Preparing to unpack .../07-postgresql-client-common_281.pgdg110+1_all.deb ...
Unpacking postgresql-client-common (281.pgdg110+1) ...
Selecting previously unselected package libio-pty-perl.
Preparing to unpack .../08-libio-pty-perl_1%3a1.15-2_amd64.deb ...
Unpacking libio-pty-perl (1:1.15-2) ...
Selecting previously unselected package libipc-run-perl.
Preparing to unpack .../09-libipc-run-perl_20200505.0-1_all.deb ...
Unpacking libipc-run-perl (20200505.0-1) ...
Selecting previously unselected package postgresql-common-dev.
Preparing to unpack .../10-postgresql-common-dev_281.pgdg110+1_all.deb ...
Unpacking postgresql-common-dev (281.pgdg110+1) ...
Selecting previously unselected package openssl.
Preparing to unpack .../11-openssl_1.1.1w-0+deb11u3_amd64.deb ...
Unpacking openssl (1.1.1w-0+deb11u3) ...
Selecting previously unselected package ssl-cert.
Preparing to unpack .../12-ssl-cert_1.1.0+nmu1_all.deb ...
Unpacking ssl-cert (1.1.0+nmu1) ...
Selecting previously unselected package sensible-utils.
Preparing to unpack .../13-sensible-utils_0.0.14_all.deb ...
Unpacking sensible-utils (0.0.14) ...
Selecting previously unselected package ucf.
Preparing to unpack .../14-ucf_3.0043+deb11u2_all.deb ...
Moving old data out of the way
Unpacking ucf (3.0043+deb11u2) ...
Selecting previously unselected package postgresql-common.
Preparing to unpack .../15-postgresql-common_281.pgdg110+1_all.deb ...
Adding 'diversion of /usr/bin/pg_config to /usr/bin/pg_config.libpq-dev by postgresql-common'
Unpacking postgresql-common (281.pgdg110+1) ...
Setting up perl-modules-5.32 (5.32.1-4+deb11u4) ...
Setting up sensible-utils (0.0.14) ...
Setting up netbase (6.3) ...
Setting up openssl (1.1.1w-0+deb11u3) ...
Setting up libgdbm6:amd64 (1.19-2) ...
Setting up ssl-cert (1.1.0+nmu1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
Setting up libgdbm-compat4:amd64 (1.19-2) ...
Setting up ucf (3.0043+deb11u2) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
Setting up libperl5.32:amd64 (5.32.1-4+deb11u4) ...
Setting up perl (5.32.1-4+deb11u4) ...
Setting up libjson-perl (4.03000-1) ...
Setting up postgresql-client-common (281.pgdg110+1) ...
Setting up libio-pty-perl (1:1.15-2) ...
Setting up libipc-run-perl (20200505.0-1) ...
Setting up postgresql-common-dev (281.pgdg110+1) ...
Setting up postgresql-common (281.pgdg110+1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
Adding user postgres to group ssl-cert

Creating config file /etc/postgresql-common/createcluster.conf with new version
Building PostgreSQL dictionaries from installed myspell/hunspell packages...
Removing obsolete dictionary files:
invoke-rc.d: could not determine current runlevel
invoke-rc.d: policy-rc.d denied execution of start.
Processing triggers for libc-bin (2.31-13+deb11u13) ...
root@41eff97a5765:/#

libgdbm-compat4
libgdbm6
libio-pty-perl
libipc-run-perl
libjson-perl
libperl5.32
netbase
openssl
perl
perl-modules-5.32
postgresql-client-common
postgresql-common-dev
sensible-utils
ssl-cert
ucf
gdbm-l10n
ca-certificates
perl-doc
libterm-readline-gnu-perl
libterm-readline-perl-perl
make
libtap-harness-archive-perl
libjson-xs-perl
logrotate
postgresql-common

root@41eff97a5765:/# cat /etc/postgresql-common/createcluster.conf
# Default values for pg_createcluster(8)
# Occurrences of '%v' are replaced by the major version number,
# and '%c' by the cluster name. Use '%%' for a literal '%'.

# Create a "main" cluster when a new postgresql-NN server package is installed
# and no clusters exist yet.
#create_main_cluster = true

# Default start.conf value, must be one of "auto", "manual", and "disabled".
# See pg_createcluster(8) for more documentation.
#start_conf = 'auto'

# Default data directory.
#data_directory = '/var/lib/postgresql/%v/%c'

# Default directory for transaction logs
# Unset by default, i.e. transaction logs remain in the data directory.
#waldir = '/var/lib/postgresql/wal/%v/%c/pg_wal'

# Options to pass to initdb.
#initdb_options = ''

# The following options are copied into the new cluster's postgresql.conf:

# Enable SSL by default (using the "snakeoil" certificates installed by the
# ssl-cert package, unless configured otherwise here)
ssl = on

# Show cluster name in process title
cluster_name = '%v/%c'

# Put stats_temp_directory on tmpfs (PG <= 14)
stats_temp_directory = '/var/run/postgresql/%v-%c.pg_stat_tmp'

# Add prefix to log lines
log_line_prefix = '%%m [%%p] %%q%%u@%%d '

# Add "include_dir" in postgresql.conf
add_include_dir = 'conf.d'

# Directory for additional createcluster config
include_dir '/etc/postgresql-common/createcluster.d'
root@41eff97a5765:/#
root@41eff97a5765:/# sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf
root@41eff97a5765:/#
root@41eff97a5765:/# apt-get install -y --no-install-recommends "postgresql-16=16.9-1.pgdg110+1"
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libbsd0 libedit2 libicu67 libllvm16 libmd0 libpq5 libxml2 libxslt1.1 libz3-4 postgresql-client-16
Suggested packages:
  postgresql-doc-16
Recommended packages:
  ca-certificates sysstat
The following NEW packages will be installed:
  libbsd0 libedit2 libicu67 libllvm16 libmd0 libpq5 libxml2 libxslt1.1 libz3-4 postgresql-16 postgresql-client-16
0 upgraded, 11 newly installed, 0 to remove and 2 not upgraded.
Need to get 59.7 MB of archives.
After this operation, 253 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bullseye/main amd64 libmd0 amd64 1.0.3-3 [28.0 kB]
Get:2 http://deb.debian.org/debian bullseye/main amd64 libbsd0 amd64 0.11.3-1+deb11u1 [108 kB]
Get:3 http://deb.debian.org/debian bullseye/main amd64 libedit2 amd64 3.1-20191231-2+b1 [96.7 kB]
Get:4 http://apt.postgresql.org/pub/repos/apt bullseye-pgdg/main amd64 libpq5 amd64 17.5-1.pgdg110+1 [226 kB]
Get:5 http://apt.postgresql.org/pub/repos/apt bullseye-pgdg/main amd64 postgresql-client-16 amd64 16.9-1.pgdg110+1 [1,927 kB]
Get:6 http://deb.debian.org/debian-security bullseye-security/main amd64 libicu67 amd64 67.1-7+deb11u1 [8,624 kB]
Get:7 http://deb.debian.org/debian-security bullseye-security/main amd64 libxml2 amd64 2.9.10+dfsg-6.7+deb11u8 [694 kB]
Get:8 http://apt.postgresql.org/pub/repos/apt bullseye-pgdg/main amd64 postgresql-16 amd64 16.9-1.pgdg110+1 [17.8 MB]
Get:9 http://deb.debian.org/debian bullseye/main amd64 libz3-4 amd64 4.8.10-1 [6,949 kB]
Get:10 http://deb.debian.org/debian bullseye/main amd64 libllvm16 amd64 1:16.0.6-15~deb11u2 [23.0 MB]
Get:11 http://deb.debian.org/debian-security bullseye-security/main amd64 libxslt1.1 amd64 1.1.34-4+deb11u2 [240 kB]
Fetched 59.7 MB in 7s (9,053 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libmd0:amd64.
(Reading database ... 10238 files and directories currently installed.)
Preparing to unpack .../00-libmd0_1.0.3-3_amd64.deb ...
Unpacking libmd0:amd64 (1.0.3-3) ...
Selecting previously unselected package libbsd0:amd64.
Preparing to unpack .../01-libbsd0_0.11.3-1+deb11u1_amd64.deb ...
Unpacking libbsd0:amd64 (0.11.3-1+deb11u1) ...
Selecting previously unselected package libedit2:amd64.
Preparing to unpack .../02-libedit2_3.1-20191231-2+b1_amd64.deb ...
Unpacking libedit2:amd64 (3.1-20191231-2+b1) ...
Selecting previously unselected package libicu67:amd64.
Preparing to unpack .../03-libicu67_67.1-7+deb11u1_amd64.deb ...
Unpacking libicu67:amd64 (67.1-7+deb11u1) ...
Selecting previously unselected package libxml2:amd64.
Preparing to unpack .../04-libxml2_2.9.10+dfsg-6.7+deb11u8_amd64.deb ...
Unpacking libxml2:amd64 (2.9.10+dfsg-6.7+deb11u8) ...
Selecting previously unselected package libz3-4:amd64.
Preparing to unpack .../05-libz3-4_4.8.10-1_amd64.deb ...
Unpacking libz3-4:amd64 (4.8.10-1) ...
Selecting previously unselected package libllvm16:amd64.
Preparing to unpack .../06-libllvm16_1%3a16.0.6-15~deb11u2_amd64.deb ...
Unpacking libllvm16:amd64 (1:16.0.6-15~deb11u2) ...
Selecting previously unselected package libpq5:amd64.
Preparing to unpack .../07-libpq5_17.5-1.pgdg110+1_amd64.deb ...
Unpacking libpq5:amd64 (17.5-1.pgdg110+1) ...
Selecting previously unselected package libxslt1.1:amd64.
Preparing to unpack .../08-libxslt1.1_1.1.34-4+deb11u2_amd64.deb ...
Unpacking libxslt1.1:amd64 (1.1.34-4+deb11u2) ...
Selecting previously unselected package postgresql-client-16.
Preparing to unpack .../09-postgresql-client-16_16.9-1.pgdg110+1_amd64.deb ...
Unpacking postgresql-client-16 (16.9-1.pgdg110+1) ...
Selecting previously unselected package postgresql-16.
Preparing to unpack .../10-postgresql-16_16.9-1.pgdg110+1_amd64.deb ...
Unpacking postgresql-16 (16.9-1.pgdg110+1) ...
Setting up libicu67:amd64 (67.1-7+deb11u1) ...
Setting up libpq5:amd64 (17.5-1.pgdg110+1) ...
Setting up libz3-4:amd64 (4.8.10-1) ...
Setting up libmd0:amd64 (1.0.3-3) ...
Setting up libbsd0:amd64 (0.11.3-1+deb11u1) ...
Setting up libxml2:amd64 (2.9.10+dfsg-6.7+deb11u8) ...
Setting up postgresql-client-16 (16.9-1.pgdg110+1) ...
update-alternatives: using /usr/share/postgresql/16/man/man1/psql.1.gz to provide /usr/share/man/man1/psql.1.gz (psql.1.gz) in auto mode
Setting up libedit2:amd64 (3.1-20191231-2+b1) ...
Setting up libxslt1.1:amd64 (1.1.34-4+deb11u2) ...
Setting up libllvm16:amd64 (1:16.0.6-15~deb11u2) ...
Setting up postgresql-16 (16.9-1.pgdg110+1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
invoke-rc.d: could not determine current runlevel
invoke-rc.d: policy-rc.d denied execution of start.
Processing triggers for postgresql-common (281.pgdg110+1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
Building PostgreSQL dictionaries from installed myspell/hunspell packages...
Removing obsolete dictionary files:
Processing triggers for libc-bin (2.31-13+deb11u13) ...
root@41eff97a5765:/#

libbsd0
libedit2
libicu67
libllvm16
libmd0
libpq5
libxml2
libxslt1.1
libz3-4
postgresql-client-16
postgresql-doc-16
ca-certificates
sysstat
postgresql-16

root@41eff97a5765:/# rm -rf /var/lib/apt/lists/*
root@41eff97a5765:/# find /usr -name '*.pyc' -type f -exec bash -c 'for pyc; do dpkg -S "$pyc" &> /dev/null || rm -vf "$pyc"; done' -- '{}' +
root@41eff97a5765:/# postgres --version
postgres (PostgreSQL) 16.9 (Debian 16.9-1.pgdg110+1)
root@41eff97a5765:/#


root@41eff97a5765:/#
root@41eff97a5765:/# ls -al /usr/share/postgresql/postgresql.conf.sample.dpkg
ls: cannot access '/usr/share/postgresql/postgresql.conf.sample.dpkg': No such file or directory

root@41eff97a5765:/# ls -al /usr/share/postgresql/16/postgresql.conf.sample
-rw-r--r-- 1 root root 29756 May  6 15:55 /usr/share/postgresql/16/postgresql.conf.sample

root@41eff97a5765:/# dpkg-divert --add --rename --divert "/usr/share/postgresql/postgresql.conf.sample.dpkg" "/usr/share/postgresql/16/postgresql.conf.sample"
Adding 'local diversion of /usr/share/postgresql/16/postgresql.conf.sample to /usr/share/postgresql/postgresql.conf.sample.dpkg'
root@41eff97a5765:/#
root@41eff97a5765:/# ls -al /usr/share/postgresql/postgresql.conf.sample.dpkg
-rw-r--r-- 1 root root 29756 May  6 15:55 /usr/share/postgresql/postgresql.conf.sample.dpkg
root@41eff97a5765:/# ls -al /usr/share/postgresql/16/postgresql.conf.sample
ls: cannot access '/usr/share/postgresql/16/postgresql.conf.sample': No such file or directory
root@41eff97a5765:/#
root@41eff97a5765:/# ls -al /usr/share/postgresql/postgresql.conf.sample
ls: cannot access '/usr/share/postgresql/postgresql.conf.sample': No such file or directory
root@41eff97a5765:/# cp -v /usr/share/postgresql/postgresql.conf.sample.dpkg /usr/share/postgresql/postgresql.conf.sample
'/usr/share/postgresql/postgresql.conf.sample.dpkg' -> '/usr/share/postgresql/postgresql.conf.sample'
root@41eff97a5765:/# ls -al /usr/share/postgresql/postgresql.conf.sample
-rw-r--r-- 1 root root 29756 Aug  1 07:04 /usr/share/postgresql/postgresql.conf.sample
root@41eff97a5765:/#
root@41eff97a5765:/# pwd
/
root@41eff97a5765:/# ls -al ../postgresql.conf.sample
ls: cannot access '../postgresql.conf.sample': No such file or directory
root@41eff97a5765:/# ls -al /usr/share/postgresql/16/
total 1316
drwxr-xr-x 7 root root   4096 Aug  1 07:02 .
drwxr-xr-x 3 root root   4096 Aug  1 07:04 ..
-rw-r--r-- 1 root root     10 May  6 15:55 catalog_version
drwxr-xr-x 2 root root   4096 Aug  1 07:01 contrib
-rw-r--r-- 1 root root  33458 May  6 15:55 errcodes.txt
drwxr-xr-x 2 root root  16384 Aug  1 07:01 extension
-rw-r--r-- 1 root root   5765 May  6 15:55 fix-CVE-2024-4317.sql
-rw-r--r-- 1 root root 114975 May  6 15:55 information_schema.sql
drwxr-xr-x 4 root root   4096 Aug  1 07:01 man
-rw-r--r-- 1 root root   5625 May  6 15:55 pg_hba.conf.sample
-rw-r--r-- 1 root root   2640 May  6 15:55 pg_ident.conf.sample
-rw-r--r-- 1 root root    640 May  6 15:55 pg_service.conf.sample
-rw-r--r-- 1 root root 944104 May  6 15:55 postgres.bki
-rw-r--r-- 1 root root    278 May  6 15:55 psqlrc.sample
-rw-r--r-- 1 root root  44176 May  6 15:55 snowball_create.sql
-rw-r--r-- 1 root root  35681 May  6 15:55 sql_features.txt
-rw-r--r-- 1 root root   8895 May  6 15:55 system_constraints.sql
-rw-r--r-- 1 root root  23315 May  6 15:55 system_functions.sql
-rw-r--r-- 1 root root  50273 May  6 15:55 system_views.sql
drwxr-xr-x 2 root root   4096 Aug  1 07:01 timezonesets
drwxr-xr-x 2 root root   4096 Aug  1 07:01 tsearch_data
root@41eff97a5765:/# ln -sv ../postgresql.conf.sample "/usr/share/postgresql/16/"
'/usr/share/postgresql/16/postgresql.conf.sample' -> '../postgresql.conf.sample'
root@41eff97a5765:/# ls -al /usr/share/postgresql/16/
total 1316
drwxr-xr-x 7 root root   4096 Aug  1 07:06 .
drwxr-xr-x 3 root root   4096 Aug  1 07:04 ..
-rw-r--r-- 1 root root     10 May  6 15:55 catalog_version
drwxr-xr-x 2 root root   4096 Aug  1 07:01 contrib
-rw-r--r-- 1 root root  33458 May  6 15:55 errcodes.txt
drwxr-xr-x 2 root root  16384 Aug  1 07:01 extension
-rw-r--r-- 1 root root   5765 May  6 15:55 fix-CVE-2024-4317.sql
-rw-r--r-- 1 root root 114975 May  6 15:55 information_schema.sql
drwxr-xr-x 4 root root   4096 Aug  1 07:01 man
-rw-r--r-- 1 root root   5625 May  6 15:55 pg_hba.conf.sample
-rw-r--r-- 1 root root   2640 May  6 15:55 pg_ident.conf.sample
-rw-r--r-- 1 root root    640 May  6 15:55 pg_service.conf.sample
-rw-r--r-- 1 root root 944104 May  6 15:55 postgres.bki
lrwxrwxrwx 1 root root     25 Aug  1 07:06 postgresql.conf.sample -> ../postgresql.conf.sample
-rw-r--r-- 1 root root    278 May  6 15:55 psqlrc.sample
-rw-r--r-- 1 root root  44176 May  6 15:55 snowball_create.sql
-rw-r--r-- 1 root root  35681 May  6 15:55 sql_features.txt
-rw-r--r-- 1 root root   8895 May  6 15:55 system_constraints.sql
-rw-r--r-- 1 root root  23315 May  6 15:55 system_functions.sql
-rw-r--r-- 1 root root  50273 May  6 15:55 system_views.sql
drwxr-xr-x 2 root root   4096 Aug  1 07:01 timezonesets
drwxr-xr-x 2 root root   4096 Aug  1 07:01 tsearch_data
root@41eff97a5765:/#
root@41eff97a5765:/# sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/postgresql/postgresql.conf.sample
bash: !\1: event not found
root@41eff97a5765:/# grep -F "listen_addresses = '*'" /usr/share/postgresql/postgresql.conf.sample
root@41eff97a5765:/#

root@41eff97a5765:/# install --verbose --directory --owner postgres --group postgres --mode 3777 /var/run/postgresql
root@41eff97a5765:/#

root@41eff97a5765:/# export PGDATA=/var/lib/postgresql/data
root@41eff97a5765:/# install --verbose --directory --owner postgres --group postgres --mode 1777 "/var/lib/postgresql/data"
install: creating directory '/var/lib/postgresql/data'
root@41eff97a5765:/#

$ docker cp ~/work/code/py_code/postgres/docker-library-postgres/16/bullseye/docker-entrypoint.sh 66a11232b30b:/usr/local/bin/docker-entrypoint.sh
Successfully copied 27.6kB to 66a11232b30b:/usr/local/bin/docker-entrypoint.sh

$ docker cp ~/work/code/py_code/postgres/docker-library-postgres/16/bullseye/docker-ensure-initdb.sh 66a11232b30b:/usr/local/bin/docker-ensure-initdb.sh
Successfully copied 4.1kB to 66a11232b30b:/usr/local/bin/docker-ensure-initdb.sh
$

root@41eff97a5765:/# ls -al /usr/local/bin/
total 2348
drwxr-xr-x 1 root root       4096 Aug  1 07:11 .
drwxr-xr-x 1 root root       4096 Jul 21 00:00 ..
-rwxr-xr-x 1  501 dialout    2311 Aug  1 02:15 docker-ensure-initdb.sh
-rwxr-xr-x 1  501 dialout   25781 Aug  1 05:22 docker-entrypoint.sh
-rwxr-xr-x 1 root root    2355481 Nov  2  2023 gosu
root@41eff97a5765:/#

root@41eff97a5765:/# ln -sT docker-ensure-initdb.sh /usr/local/bin/docker-enforce-initdb.sh
root@41eff97a5765:/# ls -al /usr/local/bin/
total 2348
drwxr-xr-x 1 root root       4096 Aug  1 07:12 .
drwxr-xr-x 1 root root       4096 Jul 21 00:00 ..
lrwxrwxrwx 1 root root         23 Aug  1 07:12 docker-enforce-initdb.sh -> docker-ensure-initdb.sh
-rwxr-xr-x 1  501 dialout    2311 Aug  1 02:15 docker-ensure-initdb.sh
-rwxr-xr-x 1  501 dialout   25781 Aug  1 05:22 docker-entrypoint.sh
-rwxr-xr-x 1 root root    2355481 Nov  2  2023 gosu
root@41eff97a5765:/#






root@60b0b099faf9:/# env
HOSTNAME=60b0b099faf9
GNUPGHOME=/tmp/tmp.vjITLxMcmt
PWD=/
HOME=/root
LANG=en_US.utf8
PG_MAJOR=16
PG_VERSION=16.9-1.pgdg110+1
TERM=xterm
SHLVL=1
PYTHONDONTWRITEBYTECODE=1
PGDATA=/var/lib/postgresql/data
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/16/bin
_=/usr/bin/env
root@60b0b099faf9:/#

# docker_setup_env
root@60b0b099faf9:/# export POSTGRES_PASSWORD=mysecretpassword
root@60b0b099faf9:/# export POSTGRES_USER=postgres
root@60b0b099faf9:/# export POSTGRES_DB=postgres
root@60b0b099faf9:/# export POSTGRES_INITDB_ARGS=
root@60b0b099faf9:/#
root@60b0b099faf9:/# echo ${POSTGRES_HOST_AUTH_METHOD}

root@60b0b099faf9:/# echo ${POSTGRES_HOST_AUTH_METHOD:=}

root@60b0b099faf9:/#
root@60b0b099faf9:/# declare -g DATABASE_ALREADY_EXISTS
root@60b0b099faf9:/# echo ${DATABASE_ALREADY_EXISTS}

root@60b0b099faf9:/# declare -ag OLD_DATABASES=()
root@60b0b099faf9:/#


# docker_create_db_directories
root@60b0b099faf9:/# id -u
0
root@60b0b099faf9:/# echo "$PGDATA"
/var/lib/postgresql/data
root@60b0b099faf9:/# mkdir -p "$PGDATA"
root@60b0b099faf9:/# chmod 00700 "$PGDATA"
root@60b0b099faf9:/# mkdir -p /var/run/postgresql
root@60b0b099faf9:/# chmod 03775 /var/run/postgresql
root@60b0b099faf9:/# echo ${POSTGRES_INITDB_WALDIR}

root@60b0b099faf9:/# echo ${POSTGRES_INITDB_WALDIR:-}

root@60b0b099faf9:/# find /var/lib/postgresql/data '!' -user postgres -exec chown postgres '{}' +
root@60b0b099faf9:/# find /var/run/postgresql '!' -user postgres -exec chown postgres '{}' +
root@60b0b099faf9:/#


root@60b0b099faf9:/# su postgres
postgres@60b0b099faf9:/$ pwd
/
postgres@60b0b099faf9:/$ cd /var/lib/postgresql
postgres@60b0b099faf9:~$ pwd
/var/lib/postgresql
postgres@60b0b099faf9:~$ ls -al
total 16
drwxrwxrwt 3 postgres postgres 4096 Aug  1 08:27 .
drwxr-xr-x 1 root     root     4096 Aug  1 08:27 ..
drwx------ 2 postgres postgres 4096 Aug  1 08:27 data
postgres@60b0b099faf9:~$ ls ./data/
postgres@60b0b099faf9:~$
postgres@60b0b099faf9:~$ env
SHELL=/bin/bash
HOSTNAME=60b0b099faf9
POSTGRES_PASSWORD=mysecretpassword
GNUPGHOME=/tmp/tmp.vjITLxMcmt
PWD=/var/lib/postgresql
LOGNAME=postgres
HOME=/var/lib/postgresql
LANG=en_US.utf8
POSTGRES_INITDB_ARGS=
PG_MAJOR=16
PG_VERSION=16.9-1.pgdg110+1
TERM=xterm
USER=postgres
SHLVL=2
POSTGRES_USER=postgres
PYTHONDONTWRITEBYTECODE=1
PGDATA=/var/lib/postgresql/data
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/16/bin
MAIL=/var/mail/postgres
POSTGRES_DB=postgres
OLDPWD=/
_=/usr/bin/env
postgres@60b0b099faf9:~$

# docker_verify_minimum_env
# docker_error_old_databases

postgres@60b0b099faf9:~$ ls /docker-entrypoint-initdb.d/
postgres@60b0b099faf9:~$

# docker_init_database_dir
postgres@60b0b099faf9:~$ id -u
999
postgres@60b0b099faf9:~$ getent passwd 999
postgres:x:999:999::/var/lib/postgresql:/bin/bash
postgres@60b0b099faf9:~$ echo $?
0
postgres@60b0b099faf9:~$ echo ${POSTGRES_INITDB_WALDIR}

postgres@60b0b099faf9:~$ echo ${POSTGRES_INITDB_WALDIR:-}

postgres@60b0b099faf9:~$ eval 'initdb --username="$POSTGRES_USER" --pwfile=<(printf "%s\n" "$POSTGRES_PASSWORD")  "postgres"'
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

creating directory postgres ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... Etc/UTC
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

initdb: warning: enabling "trust" authentication for local connections
initdb: hint: You can change this by editing pg_hba.conf or using the option -A, or --auth-local and --auth-host, the next time you run initdb.

Success. You can now start the database server using:

    pg_ctl -D postgres -l logfile start

postgres@60b0b099faf9:~$
postgres@60b0b099faf9:~$ echo ${LD_PRELOAD}

postgres@60b0b099faf9:~$ echo ${LD_PRELOAD:-}

postgres@60b0b099faf9:~$
postgres@60b0b099faf9:~$ ls -al
total 20
drwxrwxrwt  4 postgres postgres 4096 Aug  1 08:40 .
drwxr-xr-x  1 root     root     4096 Aug  1 08:27 ..
drwx------  2 postgres postgres 4096 Aug  1 08:27 data
drwx------ 19 postgres postgres 4096 Aug  1 08:40 postgres
postgres@60b0b099faf9:~$ ls -al data/
total 8
drwx------ 2 postgres postgres 4096 Aug  1 08:27 .
drwxrwxrwt 4 postgres postgres 4096 Aug  1 08:40 ..
postgres@60b0b099faf9:~$ ls -al postgres/
total 128
drwx------ 19 postgres postgres  4096 Aug  1 08:40 .
drwxrwxrwt  4 postgres postgres  4096 Aug  1 08:40 ..
drwx------  5 postgres postgres  4096 Aug  1 08:40 base
drwx------  2 postgres postgres  4096 Aug  1 08:40 global
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_commit_ts
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_dynshmem
-rw-------  1 postgres postgres  5711 Aug  1 08:40 pg_hba.conf
-rw-------  1 postgres postgres  2640 Aug  1 08:40 pg_ident.conf
drwx------  4 postgres postgres  4096 Aug  1 08:40 pg_logical
drwx------  4 postgres postgres  4096 Aug  1 08:40 pg_multixact
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_notify
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_replslot
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_serial
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_snapshots
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_stat
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_stat_tmp
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_subtrans
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_tblspc
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_twophase
-rw-------  1 postgres postgres     3 Aug  1 08:40 PG_VERSION
drwx------  3 postgres postgres  4096 Aug  1 08:40 pg_wal
drwx------  2 postgres postgres  4096 Aug  1 08:40 pg_xact
-rw-------  1 postgres postgres    88 Aug  1 08:40 postgresql.auto.conf
-rw-------  1 postgres postgres 29762 Aug  1 08:40 postgresql.conf
postgres@60b0b099faf9:~$

# pg_setup_hba_conf






```
