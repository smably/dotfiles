#!/bin/bash

export DOTFILES_DIR=${DOTFILE_DIR:-$HOME/.dotfiles}

# Install Homebrew
if ! hash brew 2>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && echo
fi

# Clone dotfiles repo and run installation script
if [[ -d "$DOTFILES_DIR" ]]; then
  echo "Dotfiles directory $DOTFILES_DIR already exists. Source $DOTFILES_DIR/install.sh to install."
else
  echo "Downloading and installing dotfiles into $DOTFILES_DIR..."
  brew install gh && echo && \
    gh auth login && \
    gh repo clone smably/dotfiles "$DOTFILES_DIR" && echo && \
    source "$DOTFILES_DIR/install.sh"
fi
