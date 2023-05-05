# Class  percona::params
class percona::params {
  $ensure = present
  $version = '5.7'
  $root_password = undef
  $mysqltuner = true
  $service_name = 'mysql'
  $service_ensure = true
  $service_enable = true
  $pkg_common_default = ['percona-toolkit']
  $remove_default_accounts = true
  $monitor = false
  $monitor_privileges = ['PROCESS', 'SUPER']
  $monitor_username = ''
  $monitor_password = ''
  $monitor_hostname = ''

  $database_config = {}
}
