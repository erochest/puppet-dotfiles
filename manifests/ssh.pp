
class dotfiles::ssh {
  $user     = $dotfiles::user
  $key_file = $dotfiles::key_file

  file { '.ssh' :
    mode   => 0700,
    path   => "/home/$user/.ssh",
    owner  => $user,
    ensure => directory,
  }

  file { '.ssh/config' :
    mode    => 0700,
    path    => "/home/$user/.ssh/config",
    owner   => $user,
    content => "Host github.com\n\tStrictHostKeyChecking no\n",
    require => File['.ssh'],
  }

  if $key_file != nil {
    file { 'id_rsa' :
      mode    => 0600,
      path    => "/home/$user/.ssh/id_rsa",
      owner   => $user,
      source  => "$key_file",
      require => File['.ssh'],
    }

    file { 'id_rsa.pub' :
      mode    => 0600,
      path    => "/home/$user/.ssh/id_rsa.pub",
      owner   => $user,
      source  => "$key_file.pub",
      require => File['.ssh'],
    }
  }

}

