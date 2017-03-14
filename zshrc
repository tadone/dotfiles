#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

expand-or-complete-with-dots() {      # This bunch of code displays red dots when autocompleting
  echo -n "\e[31m......\e[0m"         # a command with the tab key, "Oh-my-zsh"-style.
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Tmux reatach to existing session
if [[ -z "$TMUX" ]] ;then
     ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
     if [[ -z "$ID" ]] ;then # if not available create a new one
         tmux new-session
     else
         tmux attach-session -t "$ID" # if available attach to it
     fi
fi

# Aliases
alias nssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q'
alias nscp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q'
alias nsftp='sftp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q'
alias ssh-nokey='ssh -o PubkeyAuthentication=no -q'
alias bashrc='$EDITOR ~/.bashrc && source ~/.bashrc'
alias ssh_config='$EDITOR ~/.ssh/config'
alias diff='colordiff "$@"'

alias dps='docker ps'
