#!/bin/bash

DOTFILES_DIR=${DOTFILE_DIR:-$HOME/.dotfiles}

# Install Homebrew
if ! hash brew 2>/dev/null; then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo
fi

# Clone dotfiles repo and run installation script
if [[ -d "$DOTFILES_DIR" ]]; then
  echo "Dotfiles directory $DOTFILES_DIR already exists. Aborting."
else
  echo "Downloading and installing dotfiles into $DOTFILES_DIR..."
  brew install hub && echo && \
    hub clone smably/dotfiles "$DOTFILES_DIR" && echo && \
    source "$DOTFILES_DIR/install.sh"
fi

