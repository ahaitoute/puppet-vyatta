define vyatta::system::syslog::global (
  $ensure = present,
  $facility = $name,
  $level
) {
  if ! (defined(Concat::Fragment['syslog_global_header'])) {
    include vyatta::system::syslog

    concat::fragment { 'syslog_global_header':
      target  => "${vyatta::path}",
      content => template('vyatta/syslog_global_header.erb'),
      order   => 31,
    }
    concat::fragment { 'syslog_global_trailer':
      target  => "${vyatta::path}",
      content => template('vyatta/syslog_global_trailer.erb'),
      order   => 33,
    }
  }
  concat::fragment { "syslog_global_${facility}":
    target  => "${vyatta::path}",
    content => template('vyatta/syslog_global.erb'),
    order   => 32,
  }
}
