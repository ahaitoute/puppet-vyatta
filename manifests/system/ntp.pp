define vyatta::system::ntp (
  $ensure = present,
  $server = $name,
) {
  if ! (defined(Concat::Fragment['ntp_header'])) {
    concat::fragment { 'ntp_header':
      target  => "${vyatta::path}",
      content => template('vyatta/ntp_header.erb'),
      order   => 24,
    }
    concat::fragment { 'ntp_trailer':
      target  => "${vyatta::path}",
      content => template('vyatta/ntp_trailer.erb'),
      order   => 26,
    }
  }
  concat::fragment { "ntp_${server}":
    target  => "${vyatta::path}",
    content => template('vyatta/ntp.erb'),
    order   => 25,
  }
}
