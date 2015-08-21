# = Class: nrsysmond::service
#
# This class defines the service for nrsysmond. This is an internal class that
# should only be called from nrsysmond.
#
# Parameters
# *[enable]*: Boolean. When true, the service should be running and start on boot.
#             When false it should be disabled
#
# == Actions
#
#   - start or stop the service
#
class nrsysmond::service(
  $enabled = nrsysmond::params::service::enable
){
  service { 'newrelic-sysmond':
    ensure    => $enabled,
    enable    => $enabled,
    subscribe => Package['newrelic-sysmond'],
    require   => Class['nrsysmond::config']
  }
}
