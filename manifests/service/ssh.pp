define vyatta::service::ssh (
  $ensure = present,
  $configuration = {},
  $ssh = $name,
) {
  concat::fragment { "ssh_${ssh}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ssh.erb'),
    order   => 401,
  }
}
