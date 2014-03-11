define vyatta::policy::route_map (
  $ensure = present,
  $description = undef,
  $route_map = $name,
  $rules
) {
  concat::fragment { "route_map_${route_map}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/route_map.erb'),
    order   => 301,
  }
}
