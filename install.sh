#!/bin/bash

PRIVATE_DOTFILES_DIR=${PRIVATE_DOTFILES_DIR:-$DOTFILES_DIR-private}

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

# Restore backed up settings
read -p "Would you like to restore configs from private dotfiles repo using Mackup (Y/n)? " answer
case ${answer:0:1} in
n | N)
  ;;
*)
  if ! hash mackup 2>/dev/null; then
    echo "Installing Mackup..."
    brew install mackup
  fi
  
  if [[ ! -d "$PRIVATE_DOTFILES_DIR" ]]; then
    echo "Cloning private dotfiles into $PRIVATE_DOTFILES_DIR..."
    gh repo clone smably/dotfiles-private "$PRIVATE_DOTFILES_DIR" && echo
    ln -s "$DOTFILES_DIR/.mackup.cfg" ~
  fi
  
  echo "Restoring Mackup settings from git backup..."
  mackup restore
  echo "All done! Vim plugins will be installed on first run."
  echo
  ;;
esac
