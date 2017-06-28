<!-- README.md -->
# ntp\_master\_slave

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ntp\_master\_slave](#setup)
    * [Beginning with ntp\_master\_slave](#beginning-with-ntp_master_slave)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Quickly and easily setup NTP on all hosts on your network, with only some reaching out to
external NTP servers and the remaining using the former to synchronize their clocks.

## Setup

### Beginning with ntp\_master\_slave

## Usage

Setup NTP servers on `ntp1` and `ntp2`, let the rest use those to synchronize their clocks:
```
class { '::ntp_master_slave':
  masters => {
    'ntp1'  => [ '0.pool.ntp.org', '1.pool.ntp.org' ],
    'ntp2'  => [ '2.pool.ntp.org', '3.pool.ntp.org' ],
  },
}
```

The same using hiera:
```
# common.yaml
---
classes:
  - ntp_master_slave
ntp_master_slave::masters:
  'ntp1':
    - 0.pool.ntp.org
    - 1.pool.ntp.org
  'ntp2':
    - 2.pool.ntp.org
    - 3.pool.ntp.org
```

## Reference

#### Classes

##### ntp\_master\_slave
* master - Hash keyed by `$::hostname` to an array of reference NTP servers. (Hash[String, Array[String]])
* restrict - `::ntp::restrict` parameters. (Array[String])
* interfaces\_ignore - `::ntp:interfaces_ignore` parameter. (Optional[Array[String]])

## Limitations

* Very few configurables from the puppetlabs-ntp module are accessible.
* NTP masters must be resolvable by host name only.

## Development

Check it out on [github.com/bodhidigital/puppet-ntp\_master\_slave](https://github.com/bodhidigital/puppet-ntp_master_slave).

<!-- vim: set ts=2 sw=2 et syn=markdown: -->
