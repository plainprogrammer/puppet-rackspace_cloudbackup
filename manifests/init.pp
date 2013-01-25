# Class: rackspace_cloudbackup
#
#   A module for installing and managing the Rackspace Cloud Backup Drive Client.
#
class rackspace_cloudbackup (
  $api_username = undef,
  $api_key      = undef,
  $use_latest   = false
) {
  if $api_username == undef {
    fail('The api_username parameter is required.')
  }

  if $api_key == undef {
    fail('The api_key parameter is required.')
  }

  if $use_latest == true {
    $package_ensure = latest
  } elsif $use_latest == false {
    $package_ensure = present
  } else {
    fail('The use_latest parameter must be either true or false')
  }

  case $::osfamily {
    'Debian': {
      include rackspace_cloudbackup::debian
    }

    'RedHat': {
      include rackspace_cloudbackup::redhat
    }

    default: {
      fail('The rackspace_driveclient module does not support Unsupported.')
    }
  }

  service {'driveclient':
    ensure  => 'running',
    enable  => true,
    require => Package['driveclient']
  }
}
