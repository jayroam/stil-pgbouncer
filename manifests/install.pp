# Installation class
#
class pgbouncer::install {
  package { 'pgdg-redhat10-10-2.noarch':
    provider => 'rpm',
    ensure   => installed,
    source   => 'https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm',
  }

  package { 'pgbouncer':
    provider => 'yum',
    ensure   => $version,
    require  => [
      Package['pgdg-redhat10-10-2.noarch'],
      Accounts::Account['pgbouncer'],
    ]
  }
}