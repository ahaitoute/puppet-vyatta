class vyatta::protocols::ospf_header {
  if ! (defined(Concat::Fragment['ospf_header'])) {
    concat::fragment { 'ospf_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ospf_header.erb'),
      order   => 601,
    }
    concat::fragment { 'ospf_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/ospf_trailer.erb'),
      order   => 606,
    }
  }
}
