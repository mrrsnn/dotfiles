# Prompt stuff
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
precmd() {
  vcs_info
}
setopt prompt_subst
prompt='%F{white}%1d [%*]%F{green}${vcs_info_msg_0_} $%f '

# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# useful aliases
alias ls="ls -G"
alias ll="ls -l"

# PATH appendings
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/:/Applications/Atom.app/Contents/Resources/app/
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$NVM_DIR:$PATH"
