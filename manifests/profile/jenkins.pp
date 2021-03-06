class codyseibert::profile::jenkins (
) {

  # if defined (Class['jenkins']) == false {
  #   class { 'jenkins':
  #     executors => 0,
  #   }
  # }
  #
  # jenkins::plugin { 'git': }

  if defined (Exec['firewall']) == false {
    exec { 'firewall':
      command => 'firewall-cmd --zone=public --add-port=8080/tcp --permanent',
      path => '/usr/bin',
    }
  }

  if defined (Exec['wget']) == false {
    exec { 'wget':
      command => 'wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo',
      path => '/usr/bin',
    }
  }

  if defined (Package['java-1.7.0-openjdk']) == false {
    package { 'java-1.7.0-openjdk':
      ensure => "latest",
      provider => 'yum',
    }
  }

  if defined (Package['jenkins']) == false {
    package { 'jenkins':
      ensure => "latest",
      provider => 'yum',
      require => Package['java-1.7.0-openjdk'],
    }
  }

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

  if defined (Package['rpm-build']) == false {
    package { 'rpm-build':
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
}
