define vyatta::interfaces::openvpn (
  $ca_cert_file = undef,
  $cert_file = undef,
  $ensure = present,
  $key_file = undef,
  $local_address,
  $local_port = undef,
  $mode,
  $openvpn = $name,
  $remote_address,
  $remote_host,
  $remote_port = undef,
  $role = undef
) {

#  include vyatta

  concat::fragment { "interfaces_${openvpn}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/openvpn.erb'),
    order   => 201,
  }
}
