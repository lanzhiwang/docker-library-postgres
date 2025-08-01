#! /bin/bash
set -x

groupadd -r postgres --gid=999
useradd -r -g postgres --uid=999 --home-dir=/var/lib/postgresql --shell=/bin/bash postgres
install --verbose --directory --owner postgres --group postgres --mode 1777 /var/lib/postgresql

apt-get update
apt-get install -y --no-install-recommends gnupg less
rm -rf /var/lib/apt/lists/*

savedAptMark="$(apt-mark showmanual)"
apt-get update
apt-get install -y --no-install-recommends ca-certificates wget
rm -rf /var/lib/apt/lists/*
dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"
wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.17/gosu-$dpkgArch"
wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.17/gosu-$dpkgArch.asc"
export GNUPGHOME="$(mktemp -d)"
gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu
gpgconf --kill all
rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc
apt-mark auto '.*' > /dev/null
[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null
apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false
chmod +x /usr/local/bin/gosu
gosu --version
gosu nobody true

grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker
sed -ri '/\/usr\/share\/locale/d' /etc/dpkg/dpkg.cfg.d/docker
! grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker
apt-get update
apt-get install -y --no-install-recommends locales
rm -rf /var/lib/apt/lists/*
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
locale -a | grep 'en_US.utf8'

export LANG=en_US.utf8

apt-get update
apt-get install -y --no-install-recommends libnss-wrapper xz-utils zstd
rm -rf /var/lib/apt/lists/*

mkdir /docker-entrypoint-initdb.d

key='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8'
export GNUPGHOME="$(mktemp -d)"
mkdir -p /usr/local/share/keyrings/
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"
gpg --batch --export --armor "$key" > /usr/local/share/keyrings/postgres.gpg.asc
gpgconf --kill all
rm -rf "$GNUPGHOME"

export PG_MAJOR=16
export PATH=$PATH:/usr/lib/postgresql/$PG_MAJOR/bin
export PG_VERSION=16.9-1.pgdg110+1

export PYTHONDONTWRITEBYTECODE=1
dpkgArch="$(dpkg --print-architecture)"
aptRepo="[ signed-by=/usr/local/share/keyrings/postgres.gpg.asc ] http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main 16"
echo "deb $aptRepo" > /etc/apt/sources.list.d/pgdg.list
apt-get update
apt-get install -y --no-install-recommends postgresql-common
sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf
apt-get install -y --no-install-recommends "postgresql-16=16.9-1.pgdg110+1"
rm -rf /var/lib/apt/lists/*
find /usr -name '*.pyc' -type f -exec bash -c 'for pyc; do dpkg -S "$pyc" &> /dev/null || rm -vf "$pyc"; done' -- '{}' +
postgres --version

dpkg-divert --add --rename --divert "/usr/share/postgresql/postgresql.conf.sample.dpkg" "/usr/share/postgresql/16/postgresql.conf.sample"
cp -v /usr/share/postgresql/postgresql.conf.sample.dpkg /usr/share/postgresql/postgresql.conf.sample
ln -sv ../postgresql.conf.sample "/usr/share/postgresql/16/"
sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/postgresql/postgresql.conf.sample
grep -F "listen_addresses = '*'" /usr/share/postgresql/postgresql.conf.sample

install --verbose --directory --owner postgres --group postgres --mode 3777 /var/run/postgresql

export PGDATA=/var/lib/postgresql/data
install --verbose --directory --owner postgres --group postgres --mode 1777 "/var/lib/postgresql/data"

cp /docker-library-postgres/16/bullseye/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
cp /docker-library-postgres/16/bullseye/docker-ensure-initdb.sh /usr/local/bin/docker-ensure-initdb.sh
ln -sT docker-ensure-initdb.sh /usr/local/bin/docker-enforce-initdb.sh

env
