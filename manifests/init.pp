# == Class: nrsysmond
#
# Full description of class nrsysmond here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { nrsysmond:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Jesse Dearing <jdearing@newrelic.com>
#
# === Copyright
#
# Copyright 2012 New Relic Inc., unless otherwise noted.
#
class nrsysmond (
  $license_key,
  $nrloglevel     = $::nrsysmond::params::loglevel,
  $nrlogfile      = $::nrsysmond::params::logfile,
  $proxy          = undef,
  $ssl_ca_bundle  = undef,
  $ssl_ca_path    = undef,
  $nrpidfile      = undef,
  $collector_host = undef,
  $timeout        = undef
) inherits nrsysmond::params {
  case $::osfamily {
    'RedHat': {
      include nrsysmond::repo::redhat
    }
    default: {
      fail("The osfamily '${::osfamily}' is currently not supported")
    }
  }

  package { 'newrelic-sysmond':
    ensure  => latest,
    require => Exec['install repo'],
  }

  class {'nrsysmond::config':
    license_key    => $license_key,
    nrloglevel     => $nrloglevel,
    nrlogfile      => $nrlogfile,
    proxy          => $proxy,
    ssl_ca_bundle  => $ssl_ca_bundle,
    ssl_ca_path    => $ssl_ca_path,
    nrpidfile      => $nrpidfile,
    collector_host => $collector_host,
    timeout        => $timeout
  }

  service { 'newrelic-sysmond':
    ensure    => running,
    enable    => true,
    subscribe => Package['newrelic-sysmond'],
    require   => Class['nrsysmond::config']
  }
}
