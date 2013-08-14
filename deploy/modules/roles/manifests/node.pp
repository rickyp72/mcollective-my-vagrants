class roles::node {
  class{"repos": } ->
  class{"puppet": } ->
  class{"nagios": } ->
  class{"mcollective": } ->
  class{"motd": } ->
  Class[$name]
}
