define vyatta::protocols::ospf (
  $ensure = present,
  $configuration,
  $ospf = $name,
) {
  concat::fragment { "ospf_${ospf}":
    target  => "${vyatta::configuration_file}",
    content => template('vyatta/ospf.erb'),
    order   => 621,
  }
}
