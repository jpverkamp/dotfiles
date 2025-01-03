# Set the title of iterm2
function title() {
  echo -ne "\033]0;"$*"\007"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"