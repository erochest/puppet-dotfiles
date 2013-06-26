
class dotfiles::dots {
  $user     = $dotfiles::user
  $dotfiles = $dotfiles::dotfiles

  exec { 'git clone dots' :
    command => 'git clone git://github.com/Ceasar/dots.git',
    cwd     => "/home/$user",
    user    => "$user",
    creates => "/home/$user/dots",
    path    => ['/bin', '/usr/bin'],
  }

  file { 'dots/plugins' :
    path    => "/home/$user/dots/plugins",
    owner   => "$user",
    ensure  => directory,
    require => Exec['git clone dots'],
  }

  exec { 'git clone dotfiles' :
    command => "git clone $dotfiles --recursive",
    cwd     => "/home/$user/dots/plugins",
    user    => "$user",
    creates => "/home/$user/dots/plugins/dotfiles",
    path    => ['/bin', '/usr/bin'],
  }

  exec { 'pip install requirements' :
    command => 'pip install --user -r requirements.txt',
    cwd     => "/home/$user/dots",
    user    => "$user",
    path    => ['/bin', '/usr/bin', '/usr/local/bin'],
    creates => "/home/$user/.local/bin/fab",
    require => [Exec['git clone dots']],
  }

  file { '.bashrc' :
    path   => "/home/$user/.bashrc",
    ensure => absent,
  }

  exec { 'fab link:plugins' :
    cwd         => "/home/$user/dots",
    user        => "$user",
    path        => ['/bin', '/usr/bin', '/usr/local/bin', "/home/$user/.local/bin"],
    environment => "HOME=/home/$user",
    creates     => "/home/$user/.bash_it",
    require     => [Exec['pip install requirements'], Exec['git clone dotfiles'], File['.bashrc']],
  }
}

