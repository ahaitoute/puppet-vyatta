define vyatta::system::syslog::file (
  $ensure = present,
  $file = $name,
  $archive_files = 5,
  $archive_size = 0,
  $facility = 'all',
  $facility_level = 'err'
) {
  if ! (defined(Concat::Fragment['syslog_file_header'])) {
    include vyatta::system::syslog

    concat::fragment { 'syslog_file_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/syslog_file_header.erb'),
      order   => 34,
    }
    concat::fragment { 'syslog_file_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/syslog_file_trailer.erb'),
      order   => 36,
    }
  }
  concat::fragment { "syslog_file_${file}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/syslog_file.erb'),
    order   => 35,
  }
}
