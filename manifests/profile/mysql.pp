class codyseibert::profile::mysql (
) {

  if defined (Exec['firewall']) == false {
    exec { 'firewall':
      command => 'firewall-cmd --zone=public --add -port=3306/tcp --permanent',
      path => '/usr/bin',
      notify => Service['firewalld'],
    }
  }

  class { '::mysql::server':
    override_options => {
      mysqld => { bind-address => '0.0.0.0'}
    },
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
        password_hash            => '*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29',
      }
    }
  }

}
