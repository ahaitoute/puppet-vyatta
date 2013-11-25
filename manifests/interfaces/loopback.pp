define vyatta::interfaces::loopback (
  $ensure = present,
  $loopback = $name,
  $address = '',
) {
  concat::fragment { "loopback_${loopback}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/loopback.erb'),
    order   => 11,
  }
}
