class codyseibert::profile::httpd (
) {

  if defined (Firewall['100 http(s) access']) == false {
    firewall { '100 http(s) access':
      dport   => [80, 443],
      proto  => tcp,
      action => accept,
    }
  }

  if defined(Class['apache']) == false {
    class { 'apache':
      default_vhost => false,
      default_mods  => false,
    }
  }

  include apache::mod::dir
  include apache::mod::headers
  include apache::mod::filter
  include apache::mod::proxy
  include apache::mod::proxy_http
  include apache::mod::deflate

  $filters = [
    'FilterDeclare   COMPRESS',
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'text/html'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'text/css'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'text/plain'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'application/json'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'application/javascript'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'image/svg+xml'\"",
    'FilterChain     COMPRESS',
    'FilterProtocol  COMPRESS DEFLATE change=yes;byteranges=no',
  ]

  if defined(Apache::Vhost['codyseibert.com']) == false {
    apache::vhost { 'codyseibert.com':
      docroot    => "/home/ghost",
      serveraliases => ['www.codyseibert.com'],
      port => 80,
      vhost_name => '*',
      directoryindex => 'index.html',
      proxy_pass => [
        {
          'path' => '/',
          'url' => "http://localhost:2368/"
        }
      ],
      filters => $filters
    }
  }

  if defined(Apache::Vhost['seibertsoftwaresolutions.com']) == false {
    apache::vhost { 'seibertsoftwaresolutions.com':
      docroot    => "/var/www/html/seibertsoftwaresolutions",
      serveraliases => ['www.seibertsoftwaresolutions.com'],
      port => 80,
      vhost_name => '*',
      directoryindex => 'index.html',
      proxy_pass => [
        {
          'path' => '/mailer',
          'url' => "http://localhost:3000"
        }
      ],
      filters => $filters,
    }
  }


  if defined(Selboolean['httpd_can_network_connect']) == false {
    selboolean { 'httpd_can_network_connect':
      persistent => true,
      value      => 'on',
    }
  }

  if defined (Service['httpd']) == false {
    service { 'httpd':
      enable => true,
      ensure => "running",
      require => Class['apache'],
    }
  }

}
