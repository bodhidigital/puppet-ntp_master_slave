# params.pp

class ntp_master_slave::params {
  $restrict           = [
    'default kod limited nomodify nopeer noquery notrap',
    '127.0.0.1',
    '::1',
  ]
  $interfaces_ignore  = undef
  $this_hostnames     = [
    $::networking['hostname'],
    $::networking['fqdn'],
  ]
  $this_ips           = delete_undef_values(flatten($::networking['interfaces'].map |$k, $v| {
    [ $v['ip'], $v['ip6'] ]
  }))
  $this_hosts         = concat($this_hostnames, $this_ips)
}

# vim: set ts=2 sw=2 et syn=puppet:
