class vyatta (
  $script_dir = '/tmp',
  $configuration = '/config/config.puppet',
  $host_name = $hostname,
  $time_zone = $timezone
) {
  concat { $configuration:
    owner => root,
    group => root,
    mode  => '0644',
  }
  concat::fragment { "interfaces_header":
    target  => "${vyatta::configuration}",
    content => template('vyatta/interfaces_header.erb'),
    order   => 10,
  }
  concat::fragment { "interfaces_trailer":
    target  => "${vyatta::configuration}",
    content => template('vyatta/interfaces_trailer.erb'),
    order   => 19,
  }
  concat::fragment { "system_header":
    target  => "${vyatta::configuration}",
    content => template('vyatta/system_header.erb'),
    order   => 20,
  }
  concat::fragment { "system_trailer":
    target  => "${vyatta::configuration}",
    content => template('vyatta/system_trailer.erb'),
    order   => 39,
  }
  file { "${script_dir}/vyatta_end_session.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0744',
    source => 'puppet:///modules/vyatta/vyatta_end_session.sh'
  }
  file { "${script_dir}/vyatta_loadFile.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0744',
    source => 'puppet:///modules/vyatta/vyatta_loadFile.sh'
  }
  file { "${script_dir}/vyatta_setup_session.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0744',
    source => 'puppet:///modules/vyatta/vyatta_setup_session.sh'
  }
  file { "${script_dir}/vyatta_snippet.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0744',
    source => 'puppet:///modules/vyatta/vyatta_snippet.sh'
  }
}
