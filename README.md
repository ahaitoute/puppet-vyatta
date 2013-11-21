puppet-vyatta
=============
# Generates and installs Vyatta configuration.

Puppet Module for Simple Text edits

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
      host_name => 'vyatta'
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

Define the system.

    vyatta::system::login { 'vyatta':
      encrypted_password => '$6$GUyv4c3u7RZwjhRx$44.RQbxRI.nMEeV.ZJx61K7xMYQpAmOR8VjdWd3Wkz7TuG44eeygBoG2u9B3Jv8Cbfr0i.JTTwnrC5MDUkclI/', #Password: vyatta
      level => 'admin'
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
