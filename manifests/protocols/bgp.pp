define vyatta::protocols::bgp (
  $ensure = present,
  $bgp = $name,
  $configuration,
) {
  concat::fragment { "bgp_${bgp}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/bgp.erb'),
    order   => 621,
  }
}
