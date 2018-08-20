# STIL pgbouncer modul
#
class pgbouncer (
  String                $version        = 'installed',
  Boolean               $manage_user    = true,
  Boolean               $manage_service = true,
  Variant[Undef,Hash]   $dbhash         = undef,
  Variant[Undef,Hash]   $rolehash       = undef,
  Variant[Undef,Hash]   $datasources    = undef,
  String                $master,
  String                $slave,
  String                $listen_port    = '6432',
  String                $config_dir     = '/etc/pgbouncer',
  String                $logfile_dir    = '/var/log/pgbouncer',
  String                $run_dir        = '/run/pgbouncer',
) {

  # Opretter brugeren til pgbouncer
  if $manage_user {
    accounts::account { 'pgbouncer':
      require => Class['accounts'],
    }
  }

  # Installation
  package { 'pgdg-redhat10-10-2.noarch':
    provider => 'rpm',
    ensure   => installed,
    source   => "https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm",
  }

  package { 'pgbouncer':
    provider => 'yum',
    ensure   => $version,
    require  => [
      Package['pgdg-redhat10-10-2.noarch'],
      Accounts::Account['pgbouncer'],
    ]
  }

  # Styring af den primære konfigurationsfil
  file { "${config_dir}/pgbouncer.ini":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('pgbouncer/pgbouncer.ini.erb'),
    require => Package['pgbouncer'],
  }

  # Af uforklarlige årsager bliver pgbouncers kataloger oprettet med forkert UID
  $list_of_dirs = [$logfile_dir, $run_dir]
  file { $list_of_dirs:
    ensure  => directory,
    owner   => pgbouncer,
    group   => pgbouncer,
    mode    => '0744',
    require => File[
      ["${config_dir}/pgbouncer.ini"],
      ["${config_dir}/userlist.txt"],
    ]
  }

  # Sørg for at pgbouncer kører og starter ved system boot
  if $manage_service {
    service { 'pgbouncer':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      subscribe  => [
        File["${config_dir}/userlist.txt"],
        File["${config_dir}/pgbouncer.ini"],
      ],
      require    => File[$list_of_dirs],
    }
  }

  # Opretter brugernavne og login credentials i /etc/pgbouncer/userlist.txt
  file { "${config_dir}/userlist.txt":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('pgbouncer/userlist.txt.erb'),
    require => Package['pgbouncer'],
  }

}
