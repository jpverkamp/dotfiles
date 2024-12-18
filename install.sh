#!/bin/bash
set -o xtrace
DIR="$(dirname -- ${BASH_SOURCE[0]} | realpath)"
SYSTEM=$(uname | tr '[:upper:]' '[:lower:]')

# Add just autocomplete for zsh
mkdir -p ~/.zsh.d/completions
just --completions zsh > ~/.zsh.d/completions/_just

# Set up autosuggestions for zsh
[ -f ~/.zsh/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
[ -f ~/.zsh/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Install/update rust
rustup update

# Disable sticky keys on Mac
if [ $SYSTEM = darwin ]; then
    defaults write -g ApplePressAndHoldEnabled -bool false
fi

# Set up symlinks
ln -snf "$DIR/bin" ~/.bin
ln -snf "$DIR/diceware.ini" ~/.diceware.ini
ln -snf "$DIR/hammerspoon" ~/.hammerspoon
ln -snf "$DIR/gitconfig" ~/.gitconfig
ln -nfs "$DIR/ssh/config.d" ~/.ssh/config.d
ln -snf "$DIR/tmux.conf" ~/.tmux.conf
ln -snf "$DIR/vimrc" ~/.vimrc
ln -snf "$DIR/zsh.d" ~/.zsh.d
ln -snf "$DIR/zshrc" ~/.zshrc

# If we haven't already, add an import to existing SSH config
if [ -f ~/.ssh/config ]; then
    if ! grep Include ~/.ssh/config; then
        echo -e "Include config.d/*\n\n$(cat ~/.ssh/config)" > ~/.ssh/config
    fi
else
    echo "Include config.d/*" > ~/.ssh/config
fi

# Configure git
git config --global user.name || git config --global user.name "JP Verkamp"
git config --global user.email || git config --global user.email me@jverkamp.com

# Generate a new SSH key for this machine if one hasn't already been generated
[ -f ~/.ssh/id_ed25519 ] || ssh-keygen -f ~/.ssh/id_ed25519 -t ed25519 -C "me@jverkamp.com" -P ""
