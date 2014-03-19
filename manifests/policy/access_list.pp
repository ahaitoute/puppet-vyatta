define vyatta::policy::access_list (
  $ensure = present,
  $access_list = $name,
  $configuration
) {
  concat::fragment { "access_list_${access_list}":
    target  => "${vyatta::configuration_file}",
    content => template('vyatta/access_list.erb'),
    order   => 301,
  }
}
