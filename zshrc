#!/usr/bin/env bash

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Add zsh completions
# fpath=(/usr/local/share/zsh-completions $fpath)

# Customize to your needs...
export EDITOR=hx
# Add pip3 user packages to path
#[ -d "$HOME/Library/Python/3.7/bin" ] && export PATH=$PATH:$HOME/Library/Python/3.7/bin

# PATH
[ -d "$HOME/bin" ] && export PATH=$PATH:$HOME/bin
[ -d "$HOME/.krew" ] && export PATH=$PATH:$HOME/.krew/bin

# Aliases
alias sshconfig='$EDITOR ~/.ssh/config'
#alias diff='colordiff "$@"'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"
alias watch="viddy -d"
# OSX iCloud
[ -d ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/ ] && alias icloud="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/"
[ -d ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/ ] && alias notes="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/Notes && l -t"
alias todo="vim ~/Notes/todo.md +$"
# Docker Aliases
#alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}"'
# Get container IP
#alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias tf='terraform'
alias cat='bat'

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
alias ecrlogin='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPO'

#SSL
#ssl_expire_check
#alias ssl_expire_check='openssl x509 -noout -in /etc/ssl/certs/ssl-cert-snakeoil.pem -dates'

# Zoxide
if [ $commands[zoxide] ]; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# ---- FZF -----
if [ $commands[fzf] ]; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --zsh)"

  # -- Use fd instead of fzf --
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

  # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
  # - The first argument to the function ($1) is the base path to start traversal
  # - See the source code (completion.{bash,zsh}) for the details.
  _fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
  }

  [[ ! -f ~/.fzf-git.sh ]] || source ~/.fzf-git.sh

  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

  export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

  # Advanced customization of fzf options via _fzf_comprun function
  # - The first argument to the function is the name of the command.
  # - You should make sure to pass the rest of the arguments to fzf.
  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
      cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
      export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
      ssh)          fzf --preview 'dig {}'                   "$@" ;;
      *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
    esac
  }
  # export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --smart-case --glob "!.git/*" --glob "!node_modules/*"'
fi

# ---- Eza (better ls) -----
if [ $commands[eza] ]; then
  alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
  alias ll='eza --group --header --group-directories-first --long --git'
fi

# ----- Bat (better cat) -----
# export BAT_THEME=tokyonight_night

# Go development
# export GOPATH="${HOME}/Code/go"

# Personal Messages
#echo "Use fd instead of find; castero for podcasts, lf for file browsing"

#autoload -U +X bashcompinit && bashcompinit
#complete -o nospace -C /usr/local/bin/terraform terraform
#autoload -U compinit && compinit -i

expand-or-complete-with-dots() {      # This bunch of code displays red dots when autocompleting
  echo -n "\e[31m......\e[0m"         # a command with the tab key, "Oh-my-zsh"-style.
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Sprout Social
export CHEF_USER=tadswider

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
