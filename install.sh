#!/bin/bash

# Init root dir
cd "$(dirname "${BASH_SOURCE[0]}")"
ROOT_DIR="$(pwd)"

# Install all the things!
echo "Would you like to install the following homebrew formulas:"
echo $(< brew-formulas.list)
read -p "(Y/n)? " answer
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
echo "Would you like to install the following homebrew casks:"
echo $(< brew-casks.list)
read -p "(Y/n)? " answer
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

# Install node
read -p "Would you like to install node (Y/n)? " answer
case ${answer:0:1} in
  n|N )
    echo
  ;;
  * )
    read -p "Enter the version you would like to install: " version
    if [[ ! -z "$version" ]]; then
      nodenv install "$version"
      echo "Done installing node"
    fi
    echo
  ;;
esac

# Install VS Code config
VS_CODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"
alias code="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
echo "Installing VS Code config to $VS_CODE_CONFIG_DIR..."
cp -i "$ROOT_DIR/settings.json" "$VS_CODE_CONFIG_DIR"
code --install-extension Shan.code-settings-sync
echo "Done installing VS Code config (open VS Code and run <shift>-<opt>-D to sync settings)"
echo

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
