define vyatta::protocols::ospf (
  $ensure = present,
  $ospf = $name,
  $passive_interface = ''
) {
  if ! (defined(Concat::Fragment['ospf_${ospf}'])) {
    include vyatta::protocols::ospf_header
  }
  concat::fragment { "ospf_${ospf}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ospf.erb'),
    order   => 602,
  }
}
