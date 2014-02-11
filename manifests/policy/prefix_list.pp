define vyatta::policy::prefix_list (
  $ensure = present,
  $description = undef,
  $prefix_list = $name,
  $rules
) {
  concat::fragment { "prefix_list_${prefix_list}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/prefix_list.erb'),
    order   => 301,
  }
}
