
class dotfiles::install {
  package { ['vim', 'tmux', 'exuberant-ctags', 'ack-grep', 'mercurial',
             'git', 'git-all', 'git-extras', 'git-flow', 'curl'] :
    ensure => installed
  }
}

