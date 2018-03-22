# init.pp

class ntp_master_slave (
  Hash[Stdlib::Host, Array[Stdlib::Host]] $masters,
  Array[String]                           $restrict           = $::ntp_master_slave::params::restrict,
  Optional[Array[String]]                 $interfaces_ignore  = $::ntp_master_slave::params::interfaces_ignore,
  Array[Stdlib::Host]                     $this_hosts         = $::ntp_master_slave::params::this_hosts,
) inherits ::ntp_master_slave::params {
  $masters_hosts    = keys($masters)
  $else_hosts       = difference($masters_hosts, $this_hosts)
  $this_as_masters  = delete($masters, $else_hosts)

  if 0 < length(keys($this_as_masters)) {
    $servers = flatten([ values($this_as_masters), $else_hosts ])
  } else {
    $servers = $masters_hosts
  }

  class { 'ntp':
    servers           => $servers,
    restrict          => $restrict,
    interfaces_ignore => $interfaces_ignore,
  }
  contain '::ntp'
}

# vim: set ts=2 sw=2 et syn=puppet:
