define vyatta::system::ntp (
  $ensure = present,
  $configuration,
  $ntp = $name,
) {
  concat::fragment { "ntp_${server}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ntp.erb'),
    order   => 506,
  }
}
