class nrsysmond::params {
  case $::osfamily {
    'RedHat': {
      if $::hardwaremodel == 'x86_64' {
        $rpm_repo_location = 'http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm'
      } else {
        $rpm_repo_location = 'http://yum.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm'
      }
    }
    'Ubuntu': {
    }
    default: {
      fail("The osfamily '${::osfamily}' is currently not supported")
    }
  }
}
