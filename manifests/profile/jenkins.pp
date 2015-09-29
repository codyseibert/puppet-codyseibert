class codyseibert::profile::jenkins (
) {

  if defined (Exec['wget']) == false {
    exec { 'wget':
      command => 'wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo',
      path => '/usr/bin',
    }
  }

  if defined (Exec['rpm']) == false {
    exec { 'rpm':
      command => 'rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key',
      path => '/usr/bin',
      require => Exec['wget'],
    }
  }

  if defined (Package['java']) == false {
    package { 'java':
      ensure => "latest",
      provider => 'yum',
    }
  }

  if defined (Package['jenkins']) == false {
    package { 'jenkins':
      ensure => "latest",
      provider => 'yum',
      require => Package['java'],
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
