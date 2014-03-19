define vyatta::policy::prefix_list (
  $ensure = present,
  $configuration,
  $prefix_list = $name,
) {
  concat::fragment { "prefix_list_${prefix_list}":
    target  => "${vyatta::configuration_file}",
    content => template('vyatta/prefix_list.erb'),
    order   => 301,
  }
}
