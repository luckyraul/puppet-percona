# == Class: percona::install

class percona::install (
  $ensure             = $percona::ensure,
  $pkg_version        = $percona::pkg_version,
  $root_password      = $percona::root_password,
  $db_config          = $percona::database_config,
  $pkg_common_default = $percona::common_packages,
  $remove_default     = $percona::remove_default_accounts,
  $service_name       = $percona::service_name,
  $service_ensure     = $percona::service_ensure,
  $service_enable     = $percona::service_enable,
  $users              = $percona::database_users,
  $grants             = $percona::database_grants,
  $databases          = $percona::database_bases,
)  inherits percona::params {
  case $pkg_version {
    '8.0': {
      $pkg_client_default = 'percona-server-client'
      $pkg_server_default = 'percona-server-server'
    }
    default: {
      $pkg_client_default = "percona-server-client-${pkg_version}"
      $pkg_server_default = "percona-server-server-${pkg_version}"
    }
  }

  package { $pkg_common_default:
    ensure  => $ensure,
  }

  class { 'mysql::client':
    package_name => $pkg_client_default,
  }

  class { 'mysql::server':
    root_password           => $root_password,
    package_name            => $pkg_server_default,
    override_options        => $db_config,
    remove_default_accounts => $remove_default,
    service_name            => $service_name,
    service_enabled         => $service_enable,
    service_manage          => $service_ensure,
    users                   => $users,
    grants                  => $grants,
    databases               => $databases,
  }
}
