# Add current repo info to the prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats "%{$Z_CLR_BLUE%}%s %b%{$Z_CLR_RESET%}"
zstyle ':vcs_info:git*' actionformats "%{$Z_CLR_BLUE%}%s %b-%a%{$Z_CLR_RESET%}"

local Z_DATE="%D{%Y-%m-%d %H:%M}"
local Z_DIRECTORY="%{$Z_CLR_GREEN%}%~%{$Z_CLR_RESET%}"
local Z_MACHINE="%{$Z_CLR_MAGENTA%}%n%{$Z_CLR_RESET%}@%{$Z_CLR_YELLOW%}%m%{$Z_CLR_RESET%}"
local Z_STATUS="%(?,%{$Z_CLR_GREEN%}^_^%f%b,%{$Z_CLR_RED%};_;%f%b)"
local Z_VCS=""

precmd() {
    vcs_info
    echo "run"
    if [[ -n ${vcs_info_msg_0_} ]]; then
        Z_VCS="{${vcs_info_msg_0_}} "
    else
        Z_VCS=""
    fi
}

# Automatically run an ls after each cd (or otherwise changing directory)
function chpwd() {
    emulate -LR zsh
    ls
}

# Control the prompt(s)
function zsh_update_prompt {
PROMPT="
┌ ${Z_STATUS} ${Z_MACHINE} ${Z_VCS}${Z_DIRECTORY}
└ "
}
precmd_functions+='zsh_update_prompt'

# Add an extra newline after the typed command and its execution
function zsh_add_newline {
    echo ""
}
preexec_functions+='zsh_add_newline'
