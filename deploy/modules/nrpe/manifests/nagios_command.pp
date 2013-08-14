define nagios::nrpe::command (
  $command,
  $ensure = present,
  $target = undef,
  use     = undef,
  $libdir = $nrpe::params::libdir,
) {

  nrpe::command { $name:
    $ensure   => $ensure,
    $command  => $command,
    $libdir   => $libdir,
  }

  @@nagios_command { $name:
    ensure       => $ensure,
    command_line => "$libdir/check_nrpe -H \$HOSTNAME\$ -c $name",
    command_name => $name,
    target       => $target,
    use          => $use,

}
