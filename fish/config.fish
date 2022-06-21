set __fish_git_prompt_color_branch blue

set -gx fish_user_paths ~/.bin ~/.work-bin
set -gx EDITOR vim

function whitespace_after_prompt --on-event fish_preexec
    printf "\n"
end

# Directory list in cyan rather than a hard to see blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad

alias temp="cd (mktemp -d /tmp/XXXXXXXX); open ."
alias todo="open ~/Dropbox/todo.code-workspace"

# https://github.com/ibraheemdev/modern-unix
alias cat="bat"
alias ls="lsd"
alias du="dust"
alias df="duf -hide-fs squashfs,aufs"
alias ps="procs"
alias ll="ls -lah"

complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

set -g fish_user_paths "/opt/homebrew/bin/" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/lib/ruby/gems/2.7.0/bin" $fish_user_paths
set -g fish_user_paths "/Library/Frameworks/Mono.framework/Versions/Current/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/opt/python@3.9/libexec/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/opt/openjdk/bin" $fish_user_paths
