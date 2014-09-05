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
set t_Co=256
# MacPorts Installer addition on 2013-10-10_at_14:15:58: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/Users/tadswider/bin:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/:$PATH
export LSCOLORS="exfxcxdxbxegedabagacad"
expand-or-complete-with-dots() {      # This bunch of code displays red dots when autocompleting
  echo -n "\e[31m......\e[0m"         # a command with the tab key, "Oh-my-zsh"-style.
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

alias find='gfind'
alias md5sum='gmd5sum'
alias sha1sum='gsha1sum'
alias sha256sum='gsha256sum'
alias sha512sum='gsha512sum'
alias here='open .'
alias top='top -o cpu'
alias seq='/opt/local/bin/gseq'
alias lshidden='ls -dA .??*'
alias gam='python $HOME/scripts/Google_Apps_Manager/gam.py'
alias less='less -R'
alias more='more -R'
alias nssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q' 
alias nscp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q'
alias nsftp='sftp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q'
alias ssh-nokey='ssh -o PubkeyAuthentication=no -q'
alias topmemproc='ps aux | head -1; ps aux | tail -n+2 | sort -nrk4 | head -$(($(tput lines)-2)) | cut -c 1-$(tput cols)'
alias port='POSIXLY_CORRECT=1 port "$@"'
alias mksshkey='ssh-keygen -b 8192 -t rsa -C "$1" -f ~/.ssh/$1.rsa'
alias bashrc='$EDITOR ~/.bashrc && source ~/.bashrc'
alias bash_aliases='$EDITOR ~/.bash_aliases && source ~/.bash_aliases'
alias ssh_config='$EDITOR ~/.ssh/config'
alias outdated='port outdated'
alias diff='colordiff "$@"'
alias strip-ansi='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias burn='hdutil burn -verifyburn -eject "$@"'
alias flushdns='sudo killall -HUP mDNSResponder'
