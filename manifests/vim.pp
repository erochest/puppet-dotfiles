
class dotfiles::vim {
  $user = $dotfiles::user

  file { "/home/$user/.vim/vimrc" :
    ensure  => link,
    target  => "/home/$user/.vimrc",
    owner   => "$user",
  }

  exec { 'git clone vundle' :
    command     => 'git clone https://github.com/gmarik/vundle.git ./bundle/vundle',
    cwd         => "/home/$user/.vim",
    user        => "$user",
    path        => ['/bin', '/usr/bin', '/usr/local/bin', "/home/$user/.local/bin"],
    creates     => "/home/$user/.vim/bundle/vundle",
    environment => "HOME=/home/$user",
  }

  exec { 'vim +BundleInstall +qall' :
    cwd         => "/home/$user",
    user        => "$user",
    path        => ['/bin', '/usr/bin', '/usr/local/bin', "/home/$user/.local/bin"],
    environment => "HOME=/home/$user",
    require     => [File["/home/$user/.vim/vimrc"], Exec['git clone vundle']],
  }

}
