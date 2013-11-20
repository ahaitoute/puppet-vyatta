class vyatta (
  $script_dir = '/tmp',
  $configuration = '/config/config.puppet',
  $host_name = $hostname,
  $time_zone = $timezone,
  $vyatta_path = '/opt/vyatta/sbin'
) {
  concat { $configuration:
    owner => root,
    group => root,
    mode  => '0644',
#    notify => Exec["vyatta_loadFile.sh ${configuration}"]
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
    source => 'puppet:///modules/vyatta/vyatta_loadFile.sh',
    require => [File["${script_dir}/vyatta_end_session.sh"],File["${script_dir}/vyatta_setup_session.sh"]]
  }
  file { "${script_dir}/vyatta_setup_session.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0744',
    source => 'puppet:///modules/vyatta/vyatta_setup_session.sh',
    require => File["${script_dir}/vyatta_snippet.sh"]
  }
  file { "${script_dir}/vyatta_snippet.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0744',
    source => 'puppet:///modules/vyatta/vyatta_snippet.sh'
  }
  exec { "vyatta_loadFile.sh ${configuration}":
    path        => $script_dir,
#    environment => 'PATH=$PATH:/usr/local/bin:/usr/bin:/bin',
    logoutput   => true,
    subscribe   => Concat[$configuration],
    refreshonly => true,
    require     => File["${script_dir}/vyatta_loadFile.sh"]
  }
}
