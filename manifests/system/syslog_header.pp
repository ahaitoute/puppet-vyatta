class vyatta::system::syslog_header {
  if ! (defined(Concat::Fragment['syslog_header'])) {
    concat::fragment { 'syslog_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/syslog_header.erb'),
      order   => 513,
    }
    concat::fragment { 'syslog_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/syslog_trailer.erb'),
      order   => 518,
    }
  }
}
