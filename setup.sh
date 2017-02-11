#/bin/env bash
helper_url="https://raw.githubusercontent.com/alrra/dotfiles/master/src/os/utils.sh"
dotfiles_dir="$HOME/Projects/dotfiles"
the_user=$(whoami)
# Create Projects directory
if [[ ! -d "$HOME/Projects" ]]; then
  mkdir "$HOME/Projects"
fi
# Create .dotfiles directory
if [[ ! -d $dotfiles_dir ]]; then
  mkdir "$dotfiles_dir"
fi

# Helper Functions
if [[ -x /tmp/helper.sh ]]; then
  . "/tmp/helper.sh" || exit 1
else
  curl $helper_url -o /tmp/$helper_url && . "/tmp/helper.sh"
fi

# Ask for the administrator password upfront.
sudo -v &> /dev/nul
# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done &>/dev/null &

# Install XCode Command Line Tools
if ! xcode-select --print-path &> /dev/null; then
  xcode-select --install &> /dev/null || exit
fi

until [[ "xcode-select --print-path" ]]; do
  sleep 5
done

# Install Homebrew
if ! cmd_exists "brew"; then
  printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
fi
  # Verify
  if [[ $? -eq 0 ]]; then
    printf "\nHomebrew installed successfully"
  else
    printf "\nFailed to install Homebrew"
    exit
  fi
  # Update & Upgrade Homebrew
  printf "Updating Homebrew"
  execute "brew update"
  execute "brew upgrade"
  # Install essentials with Homebrew
  brew_install () {
    brew install $1
    printf "Installing $2"
  }

  brew_install "git" "Git"
  brew_install "zsh" "ZSH"

# Change to ZSH
brew_path=$(brew --prefix)
zsh_path="brew_path/bin/zsh"

if ! grep "$zsh_path" < /etc/shells &> /dev/null; then
  "printf '%s\n' '$zsh_path' | sudo tee -a /etc/shells"
fi
printf "\nChanging default shell to ZSH"
chsh -s "$zsh_path" &> /dev/null # Change default shell to ZSH

# Clone and link dotfiles
printf "\nChanging back to user"
su - $the_user
if ! cmd_exists "git"; then
  print_error "Git is not installed"
  exit
fi
if [[ ! -d "~/.dotfiles" ]]; then
  mkdir "~/.dotfiles"
fi
execute "git clone https://github.com/tadone/dotfiles-tad $dotfiles_dir"
