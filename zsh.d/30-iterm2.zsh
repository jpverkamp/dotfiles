# Set the title of iterm2
function title() {
  echo -ne "\033]0;"$*"\007"
}