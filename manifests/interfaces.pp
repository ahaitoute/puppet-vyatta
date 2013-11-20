define vyatta::interfaces (
  $ensure = present,
  $ethernet = $name,
  $address = undef,
  $duplex = 'auto',
  $hw_id,
  $smp_affinity = 'auto',
  $speed = 'auto'
) {
/*  concat::fragment { "interfaces_header":
    target  => "${vyatta::configuration}",
    content => template('vyatta/interfaces_header.erb'),
    order   => 10,
  }*/
  concat::fragment { "interfaces_${ethernet}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/interfaces.erb'),
    order   => 11,
  }
/*  concat::fragment { "interfaces_trailer":
    target  => "${vyatta::configuration}",
    content => template('vyatta/interfaces_trailer.erb'),
    order   => 19,
  }*/
}
