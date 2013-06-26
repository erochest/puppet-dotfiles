
class dotfiles::bash_it {
  $user    = $dotfiles::user
  $plugins = $dotfiles::bash_it_plugins
  $aliases = $dotfiles::bash_it_aliases

  file { "/home/$user/.bash_it/aliases/enabled" :
    ensure => directory,
    owner  => $user,
  }
  file { "/home/$user/.bash_it/plugins/enabled" :
    ensure => directory,
    owner  => $user,
  }

  define plugin($user) {
    file { "/home/$user/.bash_it/plugins/enabled/${name}.plugin.bash" :
      ensure  => link,
      target  => "/home/$user/.bash_it/plugins/available/${name}.plugin.bash",
      owner   => $user,
      require => File["/home/$user/.bash_it/plugins/enabled"],
    }
  }

  plugin { $plugins :
    user => $user,
  }

  define alias($user) {
    file { "/home/$user/.bash_it/aliases/enabled/${name}.aliases.bash" :
      ensure  => link,
      target  => "/home/$user/.bash_it/aliases/available/${name}.aliases.bash",
      owner   => $user,
      require => File["/home/$user/.bash_it/aliases/enabled"],
    }
  }

  alias { $aliases :
    user => $user,
  }

}

