define vyatta::interfaces::loopback (
  $ensure = present,
  $configuration,
  $loopback = $name
) {
  concat::fragment { "loopback_${loopback}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/loopback.erb'),
    order   => 201,
  }
}
