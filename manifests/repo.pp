# == Class: percona::repo
#
class percona::repo
(
    $ensure   = 'present',
    $location = 'http://repo.percona.com/apt',
    $repos    = 'main',
    $key      = {
        id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
        server => 'keys.gnupg.net',
    },
)
{
    include apt

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
