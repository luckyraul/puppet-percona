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

) inherits percona::params
{
    anchor { 'percona::begin': }
        -> class  { 'percona::repo': }
        -> class  { 'percona::install': }
        -> anchor { 'percona::end': }
}
