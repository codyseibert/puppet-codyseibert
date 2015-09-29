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

  # if defined (Package['vim']) == false {
  #   package { 'vim':
  #     ensure => "latest",
  #     provider => 'yum',
  #   }
  # }

  if defined (Package['epel-release']) == false {
    package { 'epel-release':
      ensure => "latest",
      provider => 'yum',
    }
  }

  if defined (Package['nodejs']) == false {
    package { 'nodejs':
      ensure => "latest",
      provider => 'yum',
      require => Package['epel-release'],
    }
  }

  if defined (Package['npm']) == false {
    package { 'npm':
      ensure => "latest",
      provider => 'yum',
      require => Package['nodejs'],
    }
  }

  if defined (Package['rpmbuild']) == false {
    package { 'rpmbuild':
      ensure => "latest",
      provider => 'yum',
    }
  }

  if defined (Exec['gulp']) == false {
    exec { 'gulp':
      command => 'npm install -g gulp',
      path => '/usr/bin',
      require => Package['npm']
    }
  }

  if defined (Apache::Vhost['typr.setter.rocks']) == false {
    apache::vhost { 'typr.setter.rocks':
      docroot => '/var/www/html/typr',
    }
  }

  if defined (Apache::Vhost['test.setter.rocks']) == false {
    apache::vhost { 'test.setter.rocks':
      docroot => '/var/www/html/test',
    }
  }

  if defined (Apache::Vhost['other.setter.rocks']) == false {
    apache::vhost { 'other.setter.rocks':
      docroot => '/var/www/html/other',
    }
  }

  if defined (Host['test.setter.rocks']) == false {
    host { 'test.setter.rocks':
      ip => '159.203.90.68',
    }
  }

  if defined (Host['typr.setter.rocks']) == false {
    host { 'typr.setter.rocks':
      ip => '159.203.90.68',
    }
  }

  if defined (Host['other.setter.rocks']) == false {
    host { 'other.setter.rocks':
      ip => '159.203.90.68',
    }
  }

  # if defined (Package['typr']) == false {
  #   package { 'typr':
  #     ensure => 'latest',
  #     provider => 'yum',
  #   }
  # }
}
