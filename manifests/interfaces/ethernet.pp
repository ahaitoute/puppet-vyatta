define vyatta::interfaces::ethernet (
  $ensure = present,
  $ethernet = $name,
  $address = '',
  $duplex = 'auto',
  $hw_id,
  $smp_affinity = 'auto',
  $speed = 'auto'
) {

  include vyatta

  concat::fragment { "interfaces_${ethernet}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ethernet.erb'),
    order   => 11,
  }
}
