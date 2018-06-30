#!/bin/bash

# Init root dir
cd "$(dirname "${BASH_SOURCE[0]}")"
ROOT_DIR="$(pwd)"

# Install all the things!
echo "Installing the following homebrew formulas:"
echo $(< brew-formulas.list)
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

# Install VS Code config
VS_CODE_BIN_PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
VS_CODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"
echo "Installing VS Code config to $VS_CODE_CONFIG_DIR..."
cp -i "$ROOT_DIR/settings.json" "$VS_CODE_CONFIG_DIR"
"$VS_CODE_BIN_PATH" --install-extension Shan.code-settings-sync
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
