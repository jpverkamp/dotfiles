set __fish_git_prompt_color_branch blue

set -gx fish_user_paths $fish_user_paths ~/.bin
set -gx EDITOR vim

set -gx GOPATH ~/Projects/go
set -gx fish_user_paths $fish_user_paths $GOPATH/bin

function whitespace_after_prompt --on-event fish_preexec
    printf "\n"
end

# Directory list in cyan rather than a hard to see blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad


# Ruby yo
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1
