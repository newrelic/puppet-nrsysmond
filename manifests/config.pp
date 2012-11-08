class nrsysmond::config(
  $license_key,
  $nrloglevel,
  $nrlogfile,
  $proxy          = undef,
  $ssl_ca_bundle  = undef,
  $ssl_ca_path    = undef,
  $nrpidfile      = undef,
  $collector_host = undef,
  $timeout        = undef
) inherits nrsysmond::params {
  file { '/etc/newrelic/nrsysmond.cfg':
    owner   => root,
    group   => root,
    mode    => 644,
    content => template('nrsysmond/nrsysmond.cfg.erb'),
  }
}
