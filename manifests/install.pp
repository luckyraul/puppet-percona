# == Class: percona::install

class percona::install (
  $ensure             = $percona::ensure,
  $pkg_version        = $percona::pkg_version,
  $config_file        = $percona::config_file,
  $includedir         = $percona::includedir,
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
  $mysqltuner         = $percona::mysqltuner,
  $mysqltuner_version = $percona::mysqltuner_version,
)  inherits percona::params {
  case $pkg_version {
    '5.7': {
      $pkg_client_default = "percona-server-client-${pkg_version}"
      $pkg_server_default = "percona-server-server-${pkg_version}"
    }
    default: {
      $pkg_client_default = 'percona-server-client'
      $pkg_server_default = 'percona-server-server'
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
    config_file             => $config_file,
    includedir              => $includedir,
    remove_default_accounts => $remove_default,
    service_name            => $service_name,
    service_enabled         => $service_enable,
    service_manage          => $service_ensure,
    users                   => $users,
    grants                  => $grants,
    databases               => $databases,
  }

  if ($mysqltuner) {
    file { '/usr/local/bin/mysqltuner':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0750',
      source  => "https://raw.githubusercontent.com/major/MySQLTuner-perl/refs/tags/v${mysqltuner_version}/mysqltuner.pl",
      replace => 'no',
    }
  }
}
