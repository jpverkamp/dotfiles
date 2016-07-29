set __fish_git_prompt_color_branch blue

set -Ux fish_user_paths $fish_user_paths ~/.bin
set -Ux EDITOR vim

set -Ux GOPATH ~/Projects/go
set -Ux fish_user_paths $fish_user_paths $GOPATH/bin

function whitespace_after_prompt --on-event fish_preexec
    printf "\n"
end

# Directory list in cyan rather than a hard to see blue
set -Ux LSCOLORS gxfxcxdxbxegedabagacad
