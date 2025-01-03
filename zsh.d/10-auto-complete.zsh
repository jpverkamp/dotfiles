zinit light zsh-users/zsh-completions

autoload -U compinit
compinit

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
