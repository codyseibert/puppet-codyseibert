class codyseibert::profile::prod (
) {
  yumrepo { 'codyseibert':
    name => "codyseibert",
    descr => "codyseibert",
    gpgcheck => 0,
    enabled => 1,
    mirrorlist => absent,
    repo_gpgcheck => 0,
    baseurl => 'http://104.131.253.44/repo',
    ensure => present,
    http_caching => 'none',
    metadata_expire => 1
  }

  if defined(Class['apache']) == false {
    class { 'apache': }
  }

  if defined (Service['httpd']) == false {
    service { 'httpd':
      enable => true,
      ensure => "running",
      require => Class['apache'],
    }
  }

  if defined (Apache::Vhost['chords.setter.rocks']) == false {
    apache::vhost { 'chords.setter.rocks':
      docroot => '/var/www/html/chords',
    }
  }

  if defined (Host['chords.setter.rocks']) == false {
    host { 'chords.setter.rocks':
      ip => '159.203.90.68',
    }
  }

  if defined (Package['chords']) == false {
    package { 'chords':
      ensure => 'latest',
      provider => 'yum',
    }
  }
}
