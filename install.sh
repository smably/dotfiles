#!/bin/bash

# Install all the things!
echo "Installing the following homebrew formulas:"
echo $(< brew-formulas.list)
echo
read -p "Would you like to continue (Y/n)? " answer
case ${answer:0:1} in
  n|N )
    echo
  ;;
  * )
    echo "Installing Homebrew formulas..."
    brew install $(< brew-formulas.list)
    echo "Done Homebrew formulas"
    echo
  ;;
esac

# Install all the other things!
echo "Installing the following homebrew casks:"
echo $(< brew-casks.list)
echo
read -p "Would you like to continue (Y/n)? " answer
case ${answer:0:1} in
  n|N )
    echo
  ;;
  * )
    echo "Installing Homebrew casks..."
    brew cask install $(< brew-casks.list)
    echo "Done Homebrew casks"
    echo
  ;;
esac

# Install powerline-go (not available in Homebrew aaargh!)
POWERLINE_GO_PATH="$HOME/go/bin/powerline-go" # TODO use $GOPATH if it's set?
if [[ ! -x "$POWERLINE_GO_PATH" ]]; then
  echo "Installing powerline-go..."
  brew install go && \
    go get -u github.com/justjanne/powerline-go && \
    brew uninstall go
  echo "Done installing powerline-go"
  echo
fi

# Install iTerm2 preferences
cd "$(dirname "${BASH_SOURCE[0]}")"
ROOT_DIR="$(pwd)"
echo "Setting default iTerm2 preferences folder to $ROOT_DIR"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$ROOT_DIR"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
echo "Done iTerm2 preferences"
echo

# Copy all the things into ~
echo "Copying dotfiles to $HOME..."
GLOBIGNORE=".:.."
cd files
for FILE in *; do
  ln -is "$ROOT_DIR/files/$FILE" "$HOME/$FILE"
done

echo
echo "All done! Vim plugins will be installed on first run."
