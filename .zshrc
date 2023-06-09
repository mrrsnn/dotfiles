[ -f ~/.zsh/.zaliases ] && source ~/.zsh/.zaliases
[ -f ~/.zsh/.zcolors ] && source ~/.zsh/.zcolors
[ -f ~/.zsh/.zmacros ] && source ~/.zsh/.zmacros

# git prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
precmd() {
  vcs_info
}
setopt prompt_subst
prompt='%F{white}%1d [%*]%F{green}${vcs_info_msg_0_} $%f '

# variables
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/:/Applications/Atom.app/Contents/Resources/app/
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$NVM_DIR:$PATH"
export LS_COLORS="$LS_COLORS:di=1;4;33"
export PNPM_HOME="/Users/nicholasmorrison/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export SPIN_BOXES="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"


# startup scripts
print_fortune_greeting() {
  cur_greeting_line=1
  greeting=$(fortune -s)
  greeting_length=$(echo $greeting | wc -l | tr -s ' ')
  echo "\n\n"
  echo "========================================================================================================================\n"
  echo $greeting | while read line; do if [[ $cur_greeting_line -eq $greeting_length ]] then figlet -f small -r -w 120 $(echo "$line"); else echo $line && ((cur_greeting_line++)); fi; done
  echo "\n"
  echo "========================================================================================================================\n"
  echo "\n"
}

check_updates_on_fresh_start() {
  fullDayInSeconds=86468
  lastDt=$(cat ~/.zsh/LAST_BREW_CHECK_DT)
  curDt=$(date -j +"%s")

  dayDiff=$(($curDt-$lastDt))


  if [[ $dayDiff -gt $fullDayInSeconds && $(pwd) == $(echo ~) ]]
  then
    brew doctor
    brew outdated
    echo $curDt > ~/.zsh/LAST_BREW_CHECK_DT
  fi
}

greetme() {
  onefetch 2> /dev/null
  if [[ $? -gt 0 ]]
  then
    print_fortune_greeting
  fi
}

greetme
check_updates_on_fresh_start

