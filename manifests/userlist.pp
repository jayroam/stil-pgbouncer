# Manages the pgbouncer userlist.txt file
#
class pgbouncer::userlist {
  # Opretter brugernavne og login credentials i /etc/pgbouncer/userlist.txt
  file { "${pgbouncer::config_dir}/userlist.txt":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('pgbouncer/userlist.txt.erb'),
    require => Package['pgbouncer'],
  }
}