define vyatta::policy::access_list (
  $ensure = present,
  $description = undef,
  $access_list = $name,
  $rules
) {
  concat::fragment { "access_list_${access_list}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/access_list.erb'),
    order   => 301,
  }
}
