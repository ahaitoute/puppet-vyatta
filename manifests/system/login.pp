define vyatta::system::login (
  $ensure = present,
  $user = $name,
  $encrypted_password,
  $key_name = undef,
  $key_content = undef,
  $key_type = undef,
  $level,
) {
  if ! (defined(Concat::Fragment['login_header'])) {
    concat::fragment { 'login_header':
      target  => "${vyatta::configuration}",
      content => template('vyatta/login_header.erb'),
      order   => 21,
    }
    concat::fragment { 'login_trailer':
      target  => "${vyatta::configuration}",
      content => template('vyatta/login_trailer.erb'),
      order   => 23,
    }
  }
  concat::fragment { "login_${user}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/login.erb'),
    order   => 22,
  }
}
