# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
precmd() {
  vcs_info
}
setopt prompt_subst
prompt='%F{white}%1d [%*]%F{green}${vcs_info_msg_0_} $%f '

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# macros
jscripts() {
  cat package.json | jq -s ".[0].scripts"
}

llpids() {
  ps -u $(whoami) -m -f | grep -e "$1" | grep -v "grep" | awk '{print $2}' | tr '\n' '\ '
}

lljson() {
  tree -J $1 | jq $2 '.'
}

vgif() {
  ffmpeg -ss 0:00 -i $1 -t 4 -vf fps=20,scale=-1:360 $2
}

tu() {
  tmux resize-pane -U $1
}

td() {
  tmux resize-pane -D $1
}

shake-branches() {
  read "REPLY?Have you pushed up all WIP branches to origin? (y/N): ";
  REPLY=${REPLY:-y};
  if [[ "$REPLY" != [yY] ]]; then
    echo "Please push up those branches before pruning and shaking"
    return 1;
  fi
  git checkout -q main &&
    git fetch --prune -q &&
    git remote prune origin &&
    remotes=$(git branch -r --no-color | grep -v HEAD | sed 's/  origin\///g' | sort) &&
    locals=$(git branch --no-color | grep -v main | tr -d ' ' | sort) &&
    dangling=($(comm -2 -3 <(echo $locals) <(echo $remotes))) &&
    if [[ "${#dangling[@]}" != "0" ]]  then git branch -D $dangling; fi
}

fnd () {
  find $1 -not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/.vscode/*' -not -path '*/.vercel/*' -not -path '*/.next/*'
}

# aliases
alias karen="say -v Karen"
alias python="python3"
alias profedit="vim ~/.zshrc && source ~/.zshrc"
alias source-reset="source ~/.zshrc && clear"
alias gpm="pnpm --global"
alias pm="pnpm"
alias ls="gls --color -hFA --group-directories-first"
alias lsize="gls --color -ghAFS | awk '{printf \"%s\\t%s\n\", \$4, substr(\$0, index(\$0, \$8))}'"
alias l="gls -gouhAFG --color --time-style=iso --sort=width --group-directories-first"
alias ll="gls -aghuUF --color --time-style=long-iso --sort=width --group-directories-first | awk '{printf \"%s\\t%s  %s    %s\n\", \$4, \$5, \$6, substr(\$0, index(\$0, \$7))}' | tail +2"

# variables
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/:/Applications/Atom.app/Contents/Resources/app/
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$NVM_DIR:$PATH"
export LS_COLORS="$LS_COLORS:di=1;4;33"

# pnpm
export PNPM_HOME="/Users/nicholasmorrison/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# startup scripts

print_fortune_greeting() {
  cur_greeting_line=1
  greeting=$(fortune -s)
  greeting_length=$(echo $greeting | wc -l | tr -s ' ')
  echo "\n"
  echo "========================================================================================================================\n"
  echo $greeting | while read line; do if [[ $cur_greeting_line -eq $greeting_length ]] then figlet -r -w 120 $(echo "$line"); else echo $line && ((cur_greeting_line++)); fi; done
  echo "\n"
  echo "========================================================================================================================\n"
  echo "\n"
}

check_updates_on_fresh_start() {
  if [[ $(pwd) == $(echo ~) ]]
  then
    brew outdated
  fi
}

greetme() {
  onefetch 2> /dev/null
  if [[ $? -gt 0 ]]
  then
    print_fortune_greeting
  fi
}

check_updates_on_fresh_start
greetme
