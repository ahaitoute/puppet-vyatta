define vyatta::system::config-management (
  $ensure = present,
  $configuration,
  $config_management = $name,
) {
  concat::fragment { "config-management_${config_management}":
    target  => "${vyatta::configuration_file}",
    content => template('vyatta/config-management.erb'),
    order   => 506,
  }
}
