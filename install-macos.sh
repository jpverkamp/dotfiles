#!/bin/bash
set -o xtrace
DIR=$(dirname -- ${BASH_SOURCE[0]} | realpath)

# Install nix
nix-env --version || sh <(curl -L https://nixos.org/nix/install)

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

# Disable sticky keys
defaults write -g ApplePressAndHoldEnabled -bool false

# Set up symlinks
ln -sf $DIR/bin ~/.bin
ln -sf $DIR/diceware.ini ~/.diceware.ini
ln -sf $DIR/hammerspoon ~/.hammerspoon
ln -sf $DIR/gitconfig ~/.gitconfig
ln -sf $DIR/tmux.conf ~/.tmux.conf
ln -sf $DIR/vimrc ~/.vimrc
ln -sf $DIR/zsh.d ~/.zsh.d
ln -sf $DIR/zshrc ~/.zshrc

# Configure git
git config --global user.name "JP Verkamp"
git config --global user.email me@jverkamp.com
