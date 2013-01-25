# Class: rackspace_cloudbackup::redhat
#
#   Sets up the Rackspace Cloud Backup Drive Client on RedHat based systems.
#
class rackspace_cloudbackup::redhat () {
  exec {'add_yum_source':
    command => '/usr/bin/wget -O /etc/yum.repos.d/drivesrvr.repo "http://agentrepo.drivesrvr.com/redhat/drivesrvr.repo" q',
  }

  package {'driveclient':
    ensure  => $::rackspace_cloudbackup::package_ensure,
    require => Exec['add_yum_source']
  }

  # TODO configure driveclient
}
