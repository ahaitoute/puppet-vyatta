define vyatta::protocols::ospf::parameters (
  $ensure = present,
  $abr_type = 'cisco',
  $opaque_lsa = false,
  $router_id = $name
) {
  if ! (defined(Concat::Fragment['ospf_parameters_${router_id}'])) {
    include vyatta::protocols::ospf_header
  }

  concat::fragment { "ospf_parameters_${router_id}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ospf_parameters.erb'),
    order   => 602,
  }
}
