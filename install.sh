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

# Copy all the things into ~
echo "Copying dotfiles to $HOME..."
cd "$(dirname "${BASH_SOURCE[0]}")/files"
GLOBIGNORE=".:.."
FILES_DIR="$(pwd)"
for FILE in *; do
  ln -i -s "$FILES_DIR/$FILE" "$HOME/$FILE"
done

echo
echo "All done! Vim plugins will be installed on first run."
