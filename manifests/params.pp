# Class  percona::params
class percona::params {
  $ensure = present
  $version = '5.7'
  $root_password = undef
  $mysqltuner = true
  $mysqltuner_version = '2.7.0'
  $service_name = 'mysql'
  $service_ensure = true
  $service_enable = true
  $pkg_common_default = []
  $remove_default_accounts = true
  $monitor = false
  $monitor_privileges = ['PROCESS', 'SUPER']
  $monitor_username = ''
  $monitor_password = ''
  $monitor_hostname = ''

  $database_config = {}

  case $facts['os']['family'] {
    'RedHat': {
      $config_file = '/etc/my.cnf'
      $includedir  = '/etc/my.cnf.d'
    }
    'Debian': {
      $config_file = '/etc/mysql/my.cnf'
      $includedir  = '/etc/mysql/conf.d'
    }
    default: {
      fail("Unsupported platform: ${facts['os']['family']}.")
    }
  }
}
