# = Class: nrsysmond::params
#
# Provides default parameter values for nrsysmond
#
class nrsysmond::params(
  $version = 'latest',
  $log_level = 'error',
  $logfile  = '/var/log/newrelic/nrsysmond.log',
  $enabled = true
){
  case $::osfamily {
    'RedHat': {
      if $::hardwaremodel == 'x86_64' {
        $rpm_repo_location = 'http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm'
      } else {
        $rpm_repo_location = 'http://yum.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm'
      }
    }
    'Debian': {
      $apt_repo = 'http://apt.newrelic.com/debian/'
    }
    default: {
      fail("ERROR: nrsysmond is not supported on osfamily ${::osfamily}")
    }
  }
}
