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
    "FilterProvider  COMPRESS DEFLATE \"%{Content-Type} = 'text/html'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content-Type} = 'text/css'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content-Type} = 'text/plain'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content-Type} = 'application/json'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content-Type} = 'application/javascript'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content-Type} = 'image/svg+xml'\"",
    'FilterChain     COMPRESS',
    'FilterProtocol  COMPRESS DEFLATE change=yes;byteranges=no',
  ]

  # VHOST CLIENT FILE SECTION
  if defined(Apache::Vhost['typr.codyseibert.com']) == false {
    apache::vhost { 'typr.codyseibert.com':
      docroot    => "/home/typr/client",
      serveraliases => ['typr.codyseibert.com'],
      port => 80,
      vhost_name => '*',
      directoryindex => 'index.html',
      proxy_pass => [
        {
          'path' => '/api',
          'url' => "http://localhost:9000/"
        }
      ],
      filters => $filters
    }
  }

  if defined(Apache::Vhost['snipr.codyseibert.com']) == false {
    apache::vhost { 'snipr.codyseibert.com':
      docroot    => "/home/snipr/client",
      serveraliases => ['snipr.codyseibert.com'],
      port => 80,
      vhost_name => '*',
      directoryindex => 'index.html',
      proxy_pass => [
        {
          'path' => '/api',
          'url' => "http://localhost:9001/"
        }
      ],
      filters => $filters
    }
  }

  if defined(Apache::Vhost['linkr.codyseibert.com']) == false {
    apache::vhost { 'linkr.codyseibert.com':
      docroot    => "/home/linkr/client",
      serveraliases => ['linkr.codyseibert.com'],
      port => 80,
      vhost_name => '*',
      directoryindex => 'index.html',
      proxy_pass => [
        {
          'path' => '/api',
          'url' => "http://localhost:9002/"
        }
      ],
      filters => $filters
    }
  }

  if defined(Apache::Vhost['stethoscope.codyseibert.com']) == false {
    apache::vhost { 'stethoscope.codyseibert.com':
      docroot    => "/home/stethoscope/client",
      serveraliases => ['stethoscope.codyseibert.com'],
      port => 80,
      vhost_name => '*',
      directoryindex => 'index.html',
      proxy_pass => [
        {
          'path' => '/api',
          'url' => "http://localhost:9003/"
        }
      ],
      filters => $filters
    }
  }

  if defined(Apache::Vhost['setter.rocks']) == false {
    apache::vhost { 'setter.rocks':
      docroot    => "/home/setter/client",
      serveraliases => ['www.setter.rocks'],
      port => 80,
      vhost_name => '*',
      directoryindex => 'index.html',
      proxy_pass => [
        {
          'path' => '/api',
          'url' => "http://localhost:9004/"
        }
      ],
      filters => $filters
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
