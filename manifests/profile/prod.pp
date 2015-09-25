class codyseibert::profile::prod (
) {
  yumrepo { 'codyseibert':
    name => "codyseibert",
    descr => "codyseibert",
    gpgcheck => 0,
    enabled => 1,
    mirrorlist => absent,
    repo_gpgcheck => 0,
    baseurl => 'http://localhost/repo',
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

  if defined (Package['createrepo']) == false {
    package { 'createrepo':
      ensure => 'latest',
      provider => 'yum',
    }
  }

  if defined (Chron['repo']) == false {
    cron { 'repo':
      command => "/usr/sbin/createrepo /var/www/html/repo",
      user    => root,
      hour    => 0,
      minute  => 5
    }
  }

  if defined (Package['typr']) == false {
    package { 'typr':
      ensure => 'latest',
      provider => 'yum',
    }
  }
}
