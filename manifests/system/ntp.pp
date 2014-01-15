define vyatta::system::ntp (
  $ensure = present,
  $server = $name,
) {
  if ! (defined(Concat::Fragment['ntp_header'])) {
    concat::fragment { 'ntp_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ntp_header.erb'),
      order   => 505,
    }
    concat::fragment { 'ntp_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ntp_trailer.erb'),
      order   => 507,
    }
  }
  concat::fragment { "ntp_${server}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ntp.erb'),
    order   => 506,
  }
}
