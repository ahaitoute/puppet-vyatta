define vyatta::protocols::ospf::redistribute (
  $ensure = present,
  $metric = '',
  $metric_type = '',
  $route = $name,
  $route_map = ''
) {
  if ! (defined(Concat::Fragment['ospf_parameters_${router_id}'])) {
    include vyatta::protocols::ospf
  }
  if ! (defined(Concat::Fragment['ospf_redistribute_header'])) {
    concat::fragment { 'ospf_redistribute_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ospf_redistribute_header.erb'),
      order   => 63,
    }
    concat::fragment { 'ospf_redistribute_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ospf_redistribute_trailer.erb'),
      order   => 65,
    }
  }
  concat::fragment { "ospf_redistribute_${route}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ospf_redistribute.erb'),
    order   => 64,
  }
}

/*class vyatta::protocols::ospf::redistribute {
  if ! (defined(Concat::Fragment['ospf_redistribute_header'])) {
    concat::fragment { 'ospf_redistribute_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ospf_redistribute_header.erb'),
      order   => 63,
    }
    concat::fragment { 'ospf_redistribute_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ospf_redistribute_trailer.erb'),
      order   => 65,
    }
  }
}
*/
