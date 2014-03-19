define vyatta::system::package (
  $ensure = present,
  $configuration,
  $package = $name,
) {
  concat::fragment { "package_${package}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/package.erb'),
    order   => 509,
  }
}
