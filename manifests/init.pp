# == Class: aptupdate
#
# Run update nad upgrade once only.
#
# === Parameters
#
#  None.
#
#
# === Examples
#
#  class { aptupdate:
#  }
#
#
# === Authors
#
# Piers Harding <piers@ompka.net>
#
# === Copyright
#
# Copyright 2014 Piers Harding.
#
#
class aptupdate {

  $sentinel = "/var/lib/apt/first-puppet-run"

  exec { "apt-get update":
    command => "/usr/bin/apt-get update && touch ${sentinel}",
    onlyif => "/usr/bin/env test \\! -f ${sentinel} || /usr/bin/env test \\! -z \"$(find /etc/apt -type f -c newer ${sentinel})\"",
    timeout => 3600,
    notify => Exec['apt-get upgrade']
  }

  exec { "apt-get upgrade":
    command => "/usr/bin/apt-get upgrade -y",
    refreshonly => true
  }

}
