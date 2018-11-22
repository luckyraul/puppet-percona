# == Class: percona::repo
#
class percona::monitoring (
  $enabled                = $percona::monitor,
  $mysql_monitor_username = $percona::monitor_username,
  $mysql_monitor_password = $percona::monitor_password,
  $mysql_monitor_hostname = $percona::monitor_hostname,
  $privileges             = $percona::monitor_privileges,
)
{
    if($enabled) {
      mysql_user { "${mysql_monitor_username}@${mysql_monitor_hostname}":
        ensure        => present,
        password_hash => mysql::password($mysql_monitor_password),
        require       => Class['mysql::server::service'],
      }

      mysql_grant { "${mysql_monitor_username}@${mysql_monitor_hostname}/*.*":
        ensure     => present,
        user       => "${mysql_monitor_username}@${mysql_monitor_hostname}",
        table      => '*.*',
        privileges => $privileges,
        require    => Mysql_user["${mysql_monitor_username}@${mysql_monitor_hostname}"],
      }
    }
}
