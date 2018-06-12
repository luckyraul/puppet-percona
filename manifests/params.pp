# Class  percona::params
class percona::params {
    $version = '5.7'
    $root_password = undef
    $mysqltuner = true
    $service_name = 'mysql'
    $service_ensure = true
    $service_enable = true
    $pkg_common_default = ['percona-toolkit']
    $remove_default_accounts = true

    $database_config = {}
}
