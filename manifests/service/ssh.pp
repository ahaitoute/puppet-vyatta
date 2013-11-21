define vyatta::service::ssh (
  $ensure = present,
  $ssh = $name,
  $port = 22
) {
  concat::fragment { "ssh_${ssh}":
    target  => "${vyatta::configuration}",
    content => template('vyatta/ssh.erb'),
    order   => 41,
  }
}
