# Class  percona::params
class percona::params {
    $version = '5.6'
    $mysqltuner = true
    $service_ensure = true
    $service_enable = true
    $pkg_common_default = ['percona-toolkit','libmysqlclient-dev']
    $remove_default_accounts = true

    $database_config = {}
}
