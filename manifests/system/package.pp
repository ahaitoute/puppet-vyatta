define vyatta::system::package (
  $ensure = present,
  $repository = $name,
  $components,
  $distribution,
  $username = '',
  $password = '',
  $url,
) {
  if ! (defined(Concat::Fragment['package_header'])) {
    concat::fragment { 'package_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/package_header.erb'),
      order   => 27,
    }
    concat::fragment { 'package_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/package_trailer.erb'),
      order   => 29,
    }
  }
  concat::fragment { "repository_${repository}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/package.erb'),
    order   => 28,
  }
}
