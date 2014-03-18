define vyatta::policy::route_map (
  $ensure = present,
  $configuration,
  $route_map = $name,
) {
  concat::fragment { "route_map_${route_map}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/route_map.erb'),
    order   => 301,
  }
}
