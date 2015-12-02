# Store command history
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt appendhistory autocd extendedglob

# Share history between terminals
setopt inc_append_history
setopt share_history

# Don't save commands starting with a space to history
setopt hist_ignore_space
