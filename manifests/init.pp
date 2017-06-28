# manifests/init.pp

class ntp_master_slave (
  Hash[String, Array[String]] $masters,
  Array[String]               $restrict           = [
    'default kod limited nomodify nopeer noquery notrap',
    '127.0.0.1',
    '::1' ],
  Optional[Array[String]]     $interfaces_ignore  = undef,
) {
  include ::stdlib

  if (has_key($masters, $::hostname)) {
    class { 'ntp':
      servers           => $masters[$::hostname],
      restrict          => $restrict,
      interfaces_ignore => $interfaces_ignore,
    }
  } else {
    class { 'ntp':
      servers           => keys($masters),
      restrict          => $restrict,
      interfaces_ignore => $interfaces_ignore,
    }
  }
}

# vim: set ts=2 sw=2 et syn=puppet:
