puppet-vyatta
=============

Generates and installs Vyatta configuration.

Tested on Vyatta Core 6.6 R1, patches are welcome.

## Installation

Clone this repo to your Puppet modules directory

    git clone git://github.com/ahaitoute/puppet-vyatta.git vyatta

## Requirements

* [File concatenation system for Puppet] (https://github.com/puppetlabs/puppetlabs-concat)
* [Puppet Labs Standard Library module] (https://github.com/puppetlabs/puppetlabs-stdlib)

## Usage

Define the server.

    class { 'vyatta':
      configuration => '/home/vyatta/configuration',
      gateway_address => '10.0.2.2',
      host_name => 'vyatta',
      time_zone => 'Europe/Amsterdam'
    }

### vyatta::interfaces

Define the interfaces.

    vyatta::interfaces::ethernet { 'eth0':
      address => 'dhcp',
      hw_id => $macaddress_eth0
    }
    vyatta::interfaces::ethernet { 'eth1':
      address => ['192.168.1.1/24','192.168.2.1/24'],
      hw_id => $macaddress_eth1
    }
    vyatta::interfaces::loopback { 'lo':
      address => '10.0.0.1/32'
    }
    vyatta::interfaces::openvpn { 'vtun0':
      local_address => '10.4.0.1',
      mode => 'site-to-site',
      remote_address => '10.4.0.2',
      remote_host => '192.168.1.2',
      ca_cert_file => '/config/auth/ca.crt',
      cert_file => '/config/auth/vyatta.crt',
      key_file => '/config/auth/vyatta.key',
      role => 'active'
    }

### vyatta::system

Define the system.

    vyatta::system::login { 'vyatta':
      encrypted_password => '$6$GUyv4c3u7RZwjhRx$44.RQbxRI.nMEeV.ZJx61K7xMYQpAmOR8VjdWd3Wkz7TuG44eeygBoG2u9B3Jv8Cbfr0i.JTTwnrC5MDUkclI/', #Password: vyatta
      level => 'admin',
      key_name => 'user@host',
      key_content => 'Your public key',
      key_type => 'ssh-rsa'
    }
    vyatta::system::ntp { '0.vyatta.pool.ntp.org':
    }
    vyatta::system::ntp { '1.vyatta.pool.ntp.org':
    }
    vyatta::system::ntp { '2.vyatta.pool.ntp.org':
    }
    vyatta::system::package { 'community':
      components => 'main',
      distribution => 'stable',
      url => 'http://packages.vyatta.com/vyatta',
    }
    vyatta::system::package { 'puppet':
      components => 'main dependencies',
      distribution => 'stable',
      url => 'http://apt.puppetlabs.com',
    }
    vyatta::system::package { 'squeeze':
      components => 'main',
      distribution => 'stable',
      url => 'http://ftp.nl.debian.org/debian',
    }
    vyatta::system::syslog::global { 'all':
      level => 'notice'
    }
    vyatta::system::syslog::global { 'protocols':
      level => 'debug'
    }
    vyatta::system::syslog::file { 'kernel-log':
      archive_files => 10,
      archive_size => 10485760,
      facility => 'kern',
      facility_level => 'info'
    }

### vyatta::service

Define the service.

    vyatta::service::https { 'https':
    }
    vyatta::service::ssh { 'ssh':
      port => 22
    }

### vyatta::protocols

Define the protocols.

    vyatta::protocols::ospf::area { '0.0.0.0':
      network => ['192.168.1.0/24','192.168.2.0/24']
    }
    vyatta::protocols::ospf::parameters { '192.168.0.1':
      abr_type => 'standard',
      opaque_lsa => true
    }
    vyatta::protocols::ospf::redistribute { 'connected':
      metric => 1,
      metric_type => 1
    }
    vyatta::protocols::ospf::redistribute { 'bgp':
      metric => 2,
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
