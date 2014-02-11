define vyatta::protocols::bgp (
  $ensure = present,
  $bgp = $name,
  $neighbors,
  $networks = undef,
  $parameters = undef,
  $redistributes = undef
) {
  concat::fragment { "bgp_${bgp}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/bgp.erb'),
    order   => 621,
  }
}
