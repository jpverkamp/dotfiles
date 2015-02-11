# Automatically run an ls after each cd (or otherwise changing directory)
function chpwd() {
    emulate -LR zsh
    ls
}

# Prompt may change
function zsh_update_prompt {
    PROMPT="
┌ ☺ %{$Z_CLR_MAGENTA%}%n%{$Z_CLR_RESET%}@%{$Z_CLR_YELLOW%}%m$Z_GIT$Z_SVN %{$Z_CLR_GREEN%}%~%{$Z_CLR_RESET%}
└ "
}
precmd_functions+='zsh_update_prompt'

# Add an extra newline after the typed command and its execution
function zsh_add_newline {
    echo ""
}
preexec_functions+='zsh_add_newline'
