define vyatta::system::login (
  $ensure = present,
  $user = $name,
  $encrypted_password,
  $level,
) {
  concat::fragment { "login_${user}":
    target  => "${vyatta::path}",
    content => template('vyatta/login.erb'),
    order   => 21,
  }
}
