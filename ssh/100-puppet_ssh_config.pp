# Ensure the SSH client config has:
#  - IdentityFile ~/.ssh/school
#  - PasswordAuthentication no
# under a "Host *" block.

# Make sure the file exists with sane ownership/permissions
file { '/etc/ssh/ssh_config':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
}

# Ensure a Host * block exists
file_line { 'ssh_config_host_star':
  path  => '/etc/ssh/ssh_config',
  line  => 'Host *',
  match => '^Host \*$',
  require => File['/etc/ssh/ssh_config'],
}

# Declare the identity file to use
file_line { 'ssh_config_identityfile':
  path  => '/etc/ssh/ssh_config',
  line  => '    IdentityFile ~/.ssh/school',
  match => '^\s*IdentityFile\s+',
  after => '^Host \*$',
  require => File_line['ssh_config_host_star'],
}

# Refuse password authentication
file_line { 'ssh_config_passwordauth':
  path  => '/etc/ssh/ssh_config',
  line  => '    PasswordAuthentication no',
  match => '^\s*PasswordAuthentication\s+',
  after => '^Host \*$',
  require => File_line['ssh_config_host_star'],
}
