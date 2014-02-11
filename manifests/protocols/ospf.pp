define vyatta::protocols::ospf (
  $ensure = present,
  $areas,
  $ospf = $name,
  $parameters = undef,
  $passive_interface = undef,
  $passive_interface_exclude = undef,
  $redistributes = undef
) {
  concat::fragment { "ospf_${ospf}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ospf.erb'),
    order   => 621,
  }
}
