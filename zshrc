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
# Add pip3 user packages to path
[ -d "$HOME/Library/Python/3.7/bin" ] && export PATH=$PATH:$HOME/Library/Python/3.7/bin
[ -d "$HOME/bin" ] && export PATH=$PATH:$HOME/bin


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
alias sshconfig='$EDITOR ~/.ssh/config'
which bat &>/dev/null && alias cat='bat'
#alias diff='colordiff "$@"'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"
# OSX iClud

# Docker Aliases
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}"'
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Kubectl Aliases
[ $commands[kubectl] ] && source <(kubectl completion zsh)
alias kctx='kubectx'
alias kns='kubens'
alias k='kubectl'
complete -o default -F __start_kubectl k

# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias preview="fzf --preview 'bat --color \"always\" {}'"

# Add ~/bin to PATH
export PATH=$PATH:$HOME/Bin

# Small Tools
[ -f ~/bin/az_fzf.sh ] && alias azenv="~/bin/az_fzf.sh"
[ -f ~/bin/make_k8s_config.sh ] && alias kube-conf="~/bin/make_k8s_config.sh"

# Personal Messages
echo "Use fd instead of find; castero for podcasts"
