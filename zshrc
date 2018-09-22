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
# Enable bash completions
autoload bashcompinit
bashcompinit
# Source Completion scripts from Homebrew
[ -f "$(brew --prefix)/etc/bash_completion.d/az" ] && source "$(brew --prefix)/etc/bash_completion.d/az" # Azure CLI
# if [[ -s "${ZDOTDIR:-$HOME}/.az.completion" ]]; then
#   source "${ZDOTDIR:-$HOME}/.az.completion"
# fi

# Customize to your needs...
export EDITOR=vim

# Tmux reatach to existing session
# if [[ -z "$TMUX" ]] ;then
#      ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#      if [[ -z "$ID" ]] ;then # if not available create a new one
#          tmux new-session
#      else
#          tmux attach-session -t "$ID" # if available attach to it
#      fi
# fi

# Aliases
alias nssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q'
alias nscp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q'

alias ssh-nokey='ssh -o PubkeyAuthentication=no -q'
alias bashrc='$EDITOR ~/.bashrc && source ~/.bashrc'
alias ssh_config='$EDITOR ~/.ssh/config'
which bat &>/dev/null && alias cat='bat'
#alias diff='colordiff "$@"'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Docker Aliases
alias dps='docker ps'
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Kubectl Aliases
alias kctx='kubectx'
alias kns='kubens'
alias k='kubectl'
complete -o default -F __start_kubectl k

# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias preview="fzf --preview 'bat --color \"always\" {}'"

echo "Use fd instead of find"
