
class dotfiles::install {
  package { ['vim', 'tmux', 'exuberant-ctags', 'ack-grep', 'mercurial',
             'python-pip', 'python-dev', 'git-all', 'git-extras',
             'git-flow', 'curl', 'default-jdk', 'libxml2-dev', 'libxslt-dev',
             'ruby-bundler', 'tree'
             # 'git',
             ] :
    ensure => installed
  }
  ->
  exec { 'pip install autoenv' :
    path    => ['/usr', '/usr/bin', '/usr/local/bin'],
    creates => '/usr/local/bin/activate.sh',
  }

  exec { 'ack divert' :
    command => 'dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep',
    path    => ['/usr', '/usr/bin', '/usr/local/bin'],
    creates => '/usr/bin/ack',
    onlyif  => 'dpkg-divert --help',
  }
}

