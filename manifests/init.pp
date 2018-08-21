# Main class
#
class pgbouncer (
#  String              $master,
#  String              $slave,
  String              $version        = 'installed',
  Boolean             $manage_user    = true,
  String              $group          = 'pgbouncer',
  String              $user           = 'pgbouncer',
  Boolean             $manage_service = true,
  Variant[Undef,Hash] $dbhash         = undef,
  Variant[Undef,Hash] $rolehash       = undef,
  Variant[Undef,Hash] $datasources    = undef,
  String              $listen_port    = '6432',
  String              $config_dir     = '/etc/pgbouncer',
  String              $logfile_dir    = '/var/log/pgbouncer',
  String              $run_dir        = '/run/pgbouncer',
) {

  contain pgbouncer::prepare
  contain pgbouncer::install
  contain pgbouncer::config
  contain pgbouncer::service
  contain pgbouncer::userlist

}
