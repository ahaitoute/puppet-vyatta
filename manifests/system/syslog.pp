define vyatta::system::syslog (
  $ensure = present,
  $configuration,
  $syslog = $name,
) {
  concat::fragment { "syslog_${syslog}":
    target  => "${vyatta::configuration_file}",
    content => template('vyatta/syslog.erb'),
    order   => 502,
  }
}
