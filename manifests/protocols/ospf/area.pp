define vyatta::protocols::ospf::area (
  $ensure = present,
  $area = $name,
  $network
) {
  if ! (defined(Concat::Fragment['ospf_area_header'])) {
    include vyatta::protocols::ospf
  }
  concat::fragment { "ospf_area_${area}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ospf_area.erb'),
    order   => 62,
  }
}
