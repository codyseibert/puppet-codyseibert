class codyseibert::profile::mysql (
) {

  if defined (Exec['firewall']) == false {
    exec { 'firewall':
      command => 'firewall-cmd --zone=public --add-port=3306/tcp --permanent',
      path => '/usr/bin',
    }
  }

  class { '::mysql::server':
    databases   => {
      'typr'  => {
        ensure  => 'present',
        charset => 'utf8',
      },
    },
    grants => {
      'typr@%/typr.*' => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
        table      => 'typr.*',
        user       => 'typr@%',
      },
    },
    users => {
      'typr@%' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '098f6bcd4621d373cade4e832627b4f6',
      }
    }
  }

}
