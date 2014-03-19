define vyatta::interfaces::openvpn (
  $ensure = present,
  $configuration,
  $openvpn = $name
) {
  concat::fragment { "interfaces_${openvpn}":
    target  => "${vyatta::configuration_file}",
    content => template('vyatta/openvpn.erb'),
    order   => 201,
  }
}
