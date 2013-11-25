define vyatta::protocols::ospf::area (
  $ensure = present,
  $area = $name,
  $network
) {
  if ! (defined(Concat::Fragment['ospf_area_${area}'])) {
    include vyatta::protocols::ospf_header
  }
  concat::fragment { "ospf_area_${area}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ospf_area.erb'),
    order   => 62,
  }
}
