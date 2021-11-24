# == Class: percona::repo
#
class percona::repo
(
    $version = $percona::pkg_version,
    $ensure   = 'present',
    $repos    = 'main',
    $key      = {
        id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
        server => 'keyserver.ubuntu.com',
    }
)
{
    include apt

    case $version {
      '5.7': {
          $location = 'http://repo.percona.com/ps-57/apt'
      }
      '8.0': {
          $location = 'http://repo.percona.com/ps-80/apt'
      }
      default: {
          $location = 'http://repo.percona.com/apt'
      }
    }

    ::apt::source { 'percona':
        ensure   => $ensure,
        location => $location,
        release  => $::lsbdistcodename,
        repos    => $repos,
        key      => $key,
        include  => {
            src => false
        },
    }

    Exec['apt_update'] -> Class['::mysql::server']
    Exec['apt_update'] -> Class['::mysql::client']
}
