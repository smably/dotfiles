#!/bin/bash

# Init root dir
cd "$(dirname "${BASH_SOURCE[0]}")"
ROOT_DIR="$(pwd)"

# Install all the things!
read -p "Would you like to install Homebrew formulas (Y/n)? " answer
case ${answer:0:1} in
n | N)
  ;;
*)
  echo "Installing Homebrew formulas..."
  brew bundle
  echo "Done Homebrew formulas"
  echo
  ;;
esac

# Install node
read -p "Would you like to install node (Y/n)? " answer
case ${answer:0:1} in
n | N)
  ;;
*)
  read -p "Enter the version you would like to install: " version
  if [[ ! -z "$version" ]]; then
    nodenv install "$version"
    echo "Done installing node"
  fi
  echo
  ;;
esac

# Install VS Code Settings Sync
read -p "Would you like to install VS Code Settings Sync (Y/n)? " answer
case ${answer:0:1} in
n | N)
  ;;
*)
  VS_CODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"
  alias code="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  code --install-extension Shan.code-settings-sync
  echo "Done installing VS Code Settings Sync (open VS Code and run <shift>-<opt>-D to sync settings)"
  echo
  ;;
esac

# Install powerline-go (not available in Homebrew aaargh!)
read -p "Would you like to install powerline-go (Y/n)? " answer
case ${answer:0:1} in
n | N)
  ;;
*)
  curl -o /usr/local/bin/powerline-go \
    https://gitreleases.dev/gh/justjanne/powerline-go/latest/powerline-go-darwin-amd64 && \
    chmod a+x /usr/local/bin/powerline-go
  echo
  ;;
esac

# Install iTerm2 preferences
read -p "Would you like to install iTerm2 preferences (Y/n)? " answer
case ${answer:0:1} in
n | N)
  ;;
*)
  echo "Setting default iTerm2 preferences folder to $ROOT_DIR"
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$ROOT_DIR"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
  echo "Done iTerm2 preferences"
  echo
  ;;
esac

# Restore backed up settings
read -p "Would restore dotfiles from Dropbox using Mackup (Y/n)? " answer
case ${answer:0:1} in
n | N)
  ;;
*)
  echo "Restoring Mackup..."
  mackup restore
  echo "All done! Vim plugins will be installed on first run."
  echo
  ;;
esac
