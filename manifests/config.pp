# Manages the main configuration file for pgbouncer
#
class pgbouncer::config {
  # Styring af den primære konfigurationsfil
  file { "${pgbouncer::config_dir}/pgbouncer.ini":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('pgbouncer/pgbouncer.ini.erb'),
    require => Package['pgbouncer'],
  }

  # Af uforklarlige årsager bliver pgbouncers kataloger oprettet med forkert UID
  $list_of_dirs = [$pgbouncer::logfile_dir, $pgbouncer::run_dir]
  file { $list_of_dirs:
    ensure  => directory,
    owner   => pgbouncer,
    group   => pgbouncer,
    mode    => '0744',
    require => File[
      ["${pgbouncer::config_dir}/pgbouncer.ini"],
      ["${pgbouncer::config_dir}/userlist.txt"],
    ]
  }
}