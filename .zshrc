# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
precmd() {
  vcs_info
}
setopt prompt_subst
prompt='%F{white}%1d [%*]%F{green}${vcs_info_msg_0_} $%f '

# aliases
alias karen="say -v Karen"
alias python="python3"
alias profedit="vim ~/.zshrc && source ~/.zshrc"
alias gpm="pnpm --global"
alias pm="pnpm"
alias ls="gls --color -hFA --group-directories-first"
alias lsize="gls --color -ghAFS | awk '{printf \"%s\\t%s\n\", \$4, substr(\$0, index(\$0, \$8))}'"
alias l="gls -gouhAFG --color --time-style=iso --sort=width --group-directories-first"
# alias ll="gls -aghuUF --color --time-style=long-iso --sort=width --group-directories-first | awk '{printf \"%s\\t%s  %s    %s\n\", \$4, \$5, \$6, substr(\$0, index(\$0, \$7))}' | tail +2"
alias gs="git status -s -b"
alias gsw="git switch"
alias gcr="git switch -c"
alias gg="git log --oneline --graph --decorate -25"
alias gl="git log --oneline --graph --decorate --stat -5"

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

# Color constants
export CLR_reset="\x1b[0m"
export CLR_bright="\x1b[1m"
export CLR_dim="\x1b[2m"
export CLR_italics="\x1b[3m"
export CLR_underscore="\x1b[4m"
export CLR_reverseColors="\x1b[7m"
export CLR_textBlack="\x1b[30m"
export CLR_textRed="\x1b[31m"
export CLR_textGreen="\x1b[32m"
export CLR_textYellow="\x1b[33m"
export CLR_textBlue="\x1b[34m"
export CLR_textMagenta="\x1b[35m"
export CLR_textCyan="\x1b[36m"
export CLR_textGray="\x1b[90m"
export CLR_brightTextRed="\x1b[91m"
export CLR_brightTextGreen="\x1b[92m"
export CLR_brightTextYellow="\x1b[93m"
export CLR_brightTextBlue="\x1b[94m"
export CLR_brightTextMagenta="\x1b[95m"
export CLR_brightTextCyan="\x1b[96m"
export CLR_textWhite="\x1b[97m"
export CLR_bgBlack="\x1b[40m"
export CLR_bgRed="\x1b[41m"
export CLR_bgGreen="\x1b[42m"
export CLR_bgYellow="\x1b[43m"
export CLR_bgBlue="\x1b[44m"
export CLR_bgMagenta="\x1b[45m"
export CLR_bgCyan="\x1b[46m"
export CLR_bgWhite="\x1b[47m"
export CLR_bgGray="\x1b[100m"
export CLR_brightBgRed="\x1b[101m"
export CLR_brightBgGreen="\x1b[102m"
export CLR_brightBgYellow="\x1b[103m"
export CLR_brightBgBlue="\x1b[104m"
export CLR_brightBgMagent="\x1b[105m"
export CLR_brightBgCyan="\x1b[106m"
export CLR_bgWhite="\x1b[107m"


# macros
ll() {
  gls $1 -aghuUF --color --time-style=long-iso --sort=width --group-directories-first | awk '{printf "%s\t%s  %s    %s\n", $4, $5, $6, substr($0, index($0, $7))}' | tail +2
}

google() {
    search=""
    echo "Googling: $@"
    for term in $@; do
        search="$search%20$term"
    done
    open "https://www.google.com/search?q=$search"
}

youtube() {
    search=""
    echo "Youtube searching: $@"
    for term in $@; do
        search="$search%20$term"
    done
    open "https://www.youtube.com/results?search_query=$search"
}

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

ff () {
  find $1 -not -path '**/.**' -not -path '**node_modules**' 
}

ffa () {
  find $1 -not -path '**node_modules**' 
}

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
