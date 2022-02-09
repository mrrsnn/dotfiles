# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# export PS1="\[\033[31m\]nick//\W \[\033[33m\][\D{%H:%M:%S}]\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Node Version Manager setup (nvm)
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# useful aliases
alias ls="ls -G"
alias ll="ls -l"

export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/:/Applications/Atom.app/Contents/Resources/app/
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
