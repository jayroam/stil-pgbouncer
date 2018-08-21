# Requirements for doing pgbouncer install
#
class pgbouncer::prepare {
  if $pgbouncer::manage_user {

    group { $pgbouncer::group:
      ensure => present,
    }

    user { $pgbouncer::user:
      ensure  => present,
      groups  => $pgbouncer::group,
      shell   => '/sbin/nologin',
      comment => "${pgbouncer::user} created by Puppet",
      require => Group[$pgbouncer::group],
    }

  }
}