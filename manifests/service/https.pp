define vyatta::service::https (
  $ensure = present,
  $https = $name,
) {
  concat::fragment { "https_${https}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/https.erb'),
    order   => 401,
  }
}
