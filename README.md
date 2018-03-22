<!-- README.md -->
# ntp\_master\_slave

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Quickly and easily setup NTP on all hosts on your network.  Specify "masters" to
synchronize with outside hosts, the remaining "slaves" will synchronize only
against the "masters.

## Usage

Setup NTP servers on `ntp1.my.domain` and `ntp2.my.domain`, they will use the
specified reference servers as well as peer with each other.  All other hosts
will synchronize their clocks against `ntp1.my.domain` and `ntp2.my.domain`
only.

    class { '::ntp_master_slave':
      masters => {
        'ntp1.my.domain'  => [ '0.pool.ntp.org', '1.pool.ntp.org' ],
        'ntp2.my.domain'  => [ '2.pool.ntp.org', '3.pool.ntp.org' ],
      },
    }

The same using hiera:

    # common.yaml
    ---
    classes:
      - ntp_master_slave
    ntp_master_slave::masters:
      'ntp1.my.domain':
        - 0.pool.ntp.org
        - 1.pool.ntp.org
      'ntp2.my.domain':
        - 2.pool.ntp.org
        - 3.pool.ntp.org

## Reference

#### Classes

##### ntp\_master\_slave
* master - Hash keyed by `$::hostname`, `$::fqdn`, or any IP address on an
  interface to an array of reference NTP servers. (Hash[Stdlib::Host,
  Array[Stdlib::Host]])
* restrict - `::ntp::restrict` parameters. (Array[String])
* interfaces\_ignore - `::ntp:interfaces_ignore` parameter.
  (Optional[Array[String]])
* this\_hosts - Override the list of hostnames and IP addresses associated with
  this host. (Array[Stdlib::Host])

## Limitations

* Very few parameters from the `puppetlabs-ntp` module are accessible.

## Development

Check it out on
[github.com/bodhidigital/puppet-ntp\_master\_slave](https://github.com/bodhidigital/puppet-ntp_master_slave).

<!-- vim: set ts=2 sw=2 et syn=markdown: -->
