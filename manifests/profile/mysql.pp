class codyseibert::profile::mysql (
) {

  # if defined (Exec['firewall']) == false {
  #   exec { 'firewall':
  #     command => 'firewall-cmd --zone=public --add-port=3306/tcp --permanent',
  #     path => '/usr/bin',
  #   }
  # }

  class { '::mysql::server':
    # override_options => {
    #   mysqld => { bind-address => '0.0.0.0'}
    # },
    databases   => {
      'typer'  => {
        ensure  => 'present',
        charset => 'utf8',
      },
      'linkr'  => {
        ensure  => 'present',
        charset => 'utf8',
      },
      'snipr'  => {
        ensure  => 'present',
        charset => 'utf8',
      },
      'pingr'  => {
        ensure  => 'present',
        charset => 'utf8',
      },
      'setter'  => {
        ensure  => 'present',
        charset => 'utf8',
      }
    },
    grants => {
      'typer@localhost/typer.*' => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
        table      => 'typer.*',
        user       => 'typer@%',
      },
      'linkr@localhost/linkr.*' => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
        table      => 'linkr.*',
        user       => 'linkr@localhost',
      },
      'snipr@localhost/snipr.*' => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
        table      => 'snipr.*',
        user       => 'snipr@localhost',
      },
      'pingr@localhost/pingr.*' => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
        table      => 'pingr.*',
        user       => 'pingr@localhost',
      },
      'setter@localhost/setter.*' => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
        table      => 'setter.*',
        user       => 'setter@localhost',
      }
    },
    users => {
      'typer@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*341F4E7561D84BB46D4448AE5AFA38D98FCA4207',
      },
      'linkr@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*CC643370B2C9ED5D67805D848DC1DF1A69825D0A',
      },
      'snipr@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*59BE3DD02FF954CBA5344A3B25DAE39880BC793F',
      },
      'pingr@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*61B166487FB73A4FE2C97953EA6F9A0F1C2422E4',
      },
      'setter@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*F27940BD3A067E9FC3412E63D80A9EB12F528562',
      }
    }
  }

}
