define vyatta::system::login (
  $ensure = present,
  $configuration,
  $login = $name,
) {
  concat::fragment { "login_${login}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/login.erb'),
    order   => 502,
  }
}
