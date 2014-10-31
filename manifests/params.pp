class nrsysmond::params {
  case $::osfamily {
    'RedHat','Linux': {
      if $::hardwaremodel == 'x86_64' {
        $rpm_repo_location = 'http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm'
      } else {
        $rpm_repo_location = 'http://yum.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm'
      }
    }
    'Debian': {
      $apt_repo = 'http://apt.newrelic.com/debian/'
    }
  }
  $version  = 'latest'
  $loglevel = 'error'
  $logfile  = '/var/log/newrelic/nrsysmond.log'
}
