#!/bin/bash
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

# Add zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)

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
#[ -d "$HOME/Library/Python/3.7/bin" ] && export PATH=$PATH:$HOME/Library/Python/3.7/bin

# PATH
[ -d "$HOME/bin" ] && export PATH=$PATH:$HOME/bin
[ -d "$HOME/.krew" ] && export PATH=$PATH:$HOME/.krew/bin

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
# If lsd package is installed
which lsd > /dev/null 2>&1 && alias ls='lsd'

alias sshconfig='$EDITOR ~/.ssh/config'
#alias diff='colordiff "$@"'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"
# OSX iCloud
[ -d ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/ ] && alias icloud="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/"
[ -d ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/ ] && alias notes="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/Notes && l -t"
# Docker Aliases
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}"'
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Kubectl Aliases
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
# Get resources
alias kctx='kubectx'
alias kns='kubens'
alias k='kubectl'
#alias k='kubecolor'
alias kn='kubectl get nodes -o wide'
alias kp='kubectl get pods -o wide'
alias kd='kubectl get deployment -o wide'
alias ks='kubectl get svc -o wide'
# Describe K8S resources
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kdn='kubectl describe node'

#SSL
#ssl_expire_check

#complete -o default -F __start_kubectl k
complete -o default -F __start_kubectl k

alias knodedist=$'kubectl get pods -o wide --all-namespaces | awk \'{ print $NF }\' | sort | uniq -c | sort -n'
# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias preview="fzf --preview 'bat --color \"always\" {}'"

# Small Tools
[ -f ~/bin/az_fzf.sh ] && alias azenv="~/bin/az_fzf.sh"
[ -f ~/bin/make_k8s_config.sh ] && alias kube-conf="~/bin/make_k8s_config.sh"

# Z
[ -f "/usr/local/etc/profile.d/z.sh" ] && source /usr/local/etc/profile.d/z.sh

# Go development
export GOPATH="${HOME}/go"
#export GOROOT="$(brew --prefix golang)/libexec"
#export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
#export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin

test -d "${GOPATH}" || mkdir -p $HOME/go/{bin,src}
#test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# AZ CLI aliases
alias azpbase="az pipelines runs list --project=CIE --pipeline-ids 4133 3905 3886 4097 3363 3727 -o table"
alias azpapply="az pipelines runs list --project=CIE --pipeline-ids 4101 3364 3728 3941 3907 4193 -o table"

# Aliases (Terraform)
alias tf='terraform'

# Personal Messages
echo "Use fd instead of find; castero for podcasts, lf for file browsing"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
autoload -U compinit && compinit -i
