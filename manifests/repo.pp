# == Class: percona::repo
#
class percona::repo (
  $version = $percona::pkg_version,
  $ensure   = 'present',
  $repos    = 'main',
  $key      = {
    id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
    server => 'keyserver.ubuntu.com',
  }
) {
  include apt

  case $version {
    '5.7': {
      $location = 'http://repo.percona.com/ps-57/apt'
    }
    '8.0': {
      $location = 'http://repo.percona.com/ps-80/apt'
    }
    '8.4': {
      $location = 'http://repo.percona.com/ps-84-lts/apt'
    }
    default: {
      $location = 'http://repo.percona.com/apt'
    }
  }

  case $facts['os']['family'] {
    'debian': {
      case $facts['os']['distro']['codename'] {
        'bullseye','bookworm': {
          ::apt::source { 'percona':
            ensure   => $ensure,
            location => $location,
            release  => $facts['os']['distro']['codename'],
            repos    => $repos,
            key      => $key,
            include  => {
              src => false,
            },
          }
        }
        default: {
          file { '/etc/apt/sources.list.d/percona.list':
            ensure => absent,
          }
          apt::keyring { 'percona.asc':
            source  => 'https://raw.githubusercontent.com/percona/percona-repositories/refs/heads/main/deb/percona-keyring.gpg',
          } -> apt::source { 'percona':
            enabled       => true,
            source_format => 'sources',
            location      => [$location],
            repos         => [$repos],
            architecture  => [$facts['os']['architecture']],
            keyring       => '/etc/apt/keyrings/percona.asc',
          }
        }
      }
      Exec['apt_update'] -> Class['mysql::server']
      Exec['apt_update'] -> Class['mysql::client']
    }
    default: {}
  }
}
