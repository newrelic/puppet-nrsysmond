class nrsysmond::repo::ubuntu (
) inherits nrsysmond::params {
  file { '/etc/apt/sources.list.d/newrelic.list':
  }

  exec { 'wget -O- http://download.newrelic.com/548C16BF.gpg | apt-key add -':
  }
}
