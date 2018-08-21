# Manages the pgbouncer service
#
class pgbouncer::service {
  # Sørg for at pgbouncer kører og starter ved system boot
  if $pgbouncer::manage_service {
    service { 'pgbouncer':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      subscribe  => [
        File["${pgbouncer::config_dir}/userlist.txt"],
        File["${pgbouncer::config_dir}/pgbouncer.ini"],
      ],
    }
  }
}