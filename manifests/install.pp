# Installation class
#
class pgbouncer::install {
  package { 'pgdg-redhat10-10-2.noarch':
    ensure   => installed,
    provider => 'rpm',
    source   => 'https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm',
  }

  package { 'pgbouncer':
    ensure   => $pgbouncer::version,
    provider => 'yum',
    require  => [
      Package['pgdg-redhat10-10-2.noarch'],
    ]
  }
}