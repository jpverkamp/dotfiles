#!/bin/bash
set -o xtrace
DIR="$(dirname -- ${BASH_SOURCE[0]} | realpath)"
SYSTEM=$(uname | tr '[:upper:]' '[:lower:]')

# Install nix
if [ $SYSTEM = darwin ]; then
    nix-env --version || sh <(curl -L https://nixos.org/nix/install)
else 
    nix-env --version || sh <(curl -L https://nixos.org/nix/install) --daemon
fi

# Install nix packages
nix-env -iA nixpkgs.age
nix-env -iA nixpkgs.awscli
nix-env -iA nixpkgs.cargo
nix-env -iA nixpkgs.dasel
nix-env -iA nixpkgs.diceware
nix-env -iA nixpkgs.graphviz
nix-env -iA nixpkgs.htop
nix-env -iA nixpkgs.hugo
nix-env -iA nixpkgs.jq
nix-env -iA nixpkgs.python3
nix-env -iA nixpkgs.reattach-to-user-namespace
nix-env -iA nixpkgs.rustc
nix-env -iA nixpkgs.silver-searcher
nix-env -iA nixpkgs.tldr
nix-env -iA nixpkgs.tmux
nix-env -iA nixpkgs.tree
nix-env -iA nixpkgs.yarn
nix-env -iA nixpkgs.yq
nix-env -u

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
git config --global user.name "JP Verkamp"
git config --global user.email me@jverkamp.com

# Generate a new SSH key for this machine if one hasn't already been generated
[ -f ~/.ssh/id_ed25519 ] || ssh-keygen -f ~/.ssh/id_ed25519 -t ed25519 -C "me@jverkamp.com" -P ""
