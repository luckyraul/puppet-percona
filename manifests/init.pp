# == Class: Percona
class percona (
    $root_password           = $percona::params::root_password,
    $ensure                  = $percona::params::ensure,
    $service_ensure          = $percona::params::service_ensure,
    $service_enable          = $percona::params::service_enable,
    $pkg_version             = $percona::params::version,
    $database_config         = $percona::params::database_config,
    $database_users          = {},
    $database_grants         = {},
    $database_bases          = {},
    $ulimit                  = undef,
    $mysqltuner              = $percona::params::mysqltuner,
    $common_packages         = $percona::params::pkg_common_default,
    $remove_default_accounts = $percona::params::remove_default_accounts,
    # monitoring
    $monitor                 = $percona::params::monitor,
    $monitor_username        = $percona::params::monitor_username,
    $monitor_password        = $percona::params::monitor_password,
    $monitor_hostname        = $percona::params::monitor_hostname,
    $monitor_privileges      = $percona::params::monitor_privileges,

) inherits percona::params
{
    anchor { 'percona::begin': }
        -> class  { 'percona::repo': }
        -> class  { 'percona::install': }
        -> class  { 'percona::monitoring': }
        -> anchor { 'percona::end': }
}
