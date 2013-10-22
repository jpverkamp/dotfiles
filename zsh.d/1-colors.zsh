# Default color settings for a lot of things
autoload colors zsh/terminfo

# Foreground colors
Z_CLR_GRAY="$(echo -n '\e[30m')"
Z_CLR_RED="$(echo -n '\e[31m')"
Z_CLR_GREEN="$(echo -n '\e[32m')"
Z_CLR_YELLOW="$(echo -n '\e[33m')"
Z_CLR_BLUE="$(echo -n '\e[34m')"
Z_CLR_MAGENTA="$(echo -n '\e[35m')"
Z_CLR_CYAN="$(echo -n '\e[36m')"
Z_CLR_WHITE="$(echo -n '\e[37m')"

# Reset to default color
Z_CLR_RESET="$(echo -n '\e[0m')"

