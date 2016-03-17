# == Class: percona::repo
#
class percona::repo
(
    $ensure   = 'present',
    $location = 'http://repo.percona.com/apt',
    $repos    = 'main',
    $key      = {
        id     => '430BDF5C56E7C94E848EE60C1C4CBDCDCD2EFD2A',
        server => 'ha.pool.sks-keyservers.net',
    },
)
{
    include apt

    ::apt::source { 'percona':
        ensure   => $ensure,
        location => $location,
        release  => $::lsbdistcodename,
        repos    => $repos
        key      => $key,
        include  => {
            src => false
        },
    }

    Exec['apt_update'] -> Package['percona-server']
}
