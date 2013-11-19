class vyatta (
  $path = '/config/config.puppet',
  $host_name = $hostname
) {
  concat { $path:
    owner => root,
    group => root,
    mode  => '0644',
  }
  concat::fragment { "interfaces_header":
    target  => "${vyatta::path}",
    content => template('vyatta/interfaces_header.erb'),
    order   => 10,
  }
  concat::fragment { "interfaces_trailer":
    target  => "${vyatta::path}",
    content => template('vyatta/interfaces_trailer.erb'),
    order   => 19,
  }
  concat::fragment { "system_header":
    target  => "${vyatta::path}",
    content => template('vyatta/system_header.erb'),
    order   => 20,
  }
  concat::fragment { "system_trailer":
    target  => "${vyatta::path}",
    content => template('vyatta/system_trailer.erb'),
    order   => 39,
  }
}
