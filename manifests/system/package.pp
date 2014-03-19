define vyatta::system::package (
  $ensure = present,
  $configuration,
  $package = $name,
) {
  concat::fragment { "package_${package}":
    target  => "${vyatta::configuration_file}",
    content => template('vyatta/package.erb'),
    order   => 509,
  }
}
