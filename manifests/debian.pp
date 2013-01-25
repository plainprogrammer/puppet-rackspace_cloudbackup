# Class: rackspace_cloudbackup::debian
#
#   Sets up the Rackspace Cloud Backup Drive Client on Debian based systems.
#
class rackspace_cloudbackup::debian () {
  exec {'add_apt_key':
    command => '/usr/bin/wget -q "http://agentrepo.drivesrvr.com/debian/agentrepo.key" -O- | /usr/bin/apt-key add -'
  }

  exec {'add_apt_source':
    command => '/bin/echo "deb [arch=amd64] http://agentrepo.drivesrvr.com/debian/ serveragent main" > /etc/apt/sources.list.d/driveclient.list',
    require => Exec['add_apt_key']
  }

  exec {'update_apt_sources':
    command => '/usr/bin/apt-get update -qq',
    require => Exec['add_apt_source']
  }

  package {'driveclient':
    ensure  => $::rackspace_cloudbackup::package_ensure,
    require => Exec['update_apt_sources']
  }
}
