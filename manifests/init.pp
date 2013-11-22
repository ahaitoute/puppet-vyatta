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
  concat::fragment { "service_header":
    target  => "${vyatta::configuration}",
    content => template('vyatta/service_header.erb'),
    order   => 40,
  }
  concat::fragment { "service_trailer":
    target  => "${vyatta::configuration}",
    content => template('vyatta/service_trailer.erb'),
    order   => 59,
  }
  concat::fragment { "protocols_header":
    target  => "${vyatta::configuration}",
    content => template('vyatta/protocols_header.erb'),
    order   => 60,
  }
  concat::fragment { "protocols_trailer":
    target  => "${vyatta::configuration}",
    content => template('vyatta/protocols_trailer.erb'),
    order   => 79,
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
    environment => ['vyatta_prefix=/opt/vyatta','vyatta_htmldir=/opt/vyatta/share/html','vyatta_datadir=/opt/vyatta/share','vyatta_op_templates=/opt/vyatta/share/vyatta-op/templates','vyatta_sysconfdir=/opt/vyatta/etc','vyatta_sharedstatedir=/opt/vyatta/com','vyatta_sbindir=/opt/vyatta/sbin','vyatta_cfg_templates=/opt/vyatta/share/vyatta-cfg/templates','VYATTA_CFG_GROUP_NAME=vyattacfg','vyatta_bindir=/opt/vyatta/bin','VYATTA_USER_LEVEL_DIR=/opt/vyatta/etc/shell/level/admin','vyatta_libdir=/opt/vyatta/lib','vyatta_localstatedir=/opt/vyatta/var','vyatta_libexecdir=/opt/vyatta/libexec','vyatta_datarootdir=/opt/vyatta/share','vyatta_configdir=/opt/vyatta/config','vyatta_infodir=/opt/vyatta/share/info','vyatta_localedir=/opt/vyatta/share/locale'],
    logoutput   => true,
    subscribe   => Concat[$configuration],
    refreshonly => true,
    require     => File["${script_dir}/vyatta_loadFile.sh"]
  }
}
