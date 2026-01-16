zinit light zsh-users/zsh-completions

fpath+=~/.zsh.d/completions

zstyle ':completion:*:descriptions' format "%U%B%d%b%u"
zstyle ':completion:*:messages' format "%F{green}%d%f"

autoload -Uz compinit
compinit -u

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
