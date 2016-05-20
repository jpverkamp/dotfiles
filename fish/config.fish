set __fish_git_prompt_color_branch blue

set -U fish_user_paths $fish_user_paths ~/.bin
set -U EDITOR vim

set -U GOPATH=~/Projects/go
set -U fish_user_paths $fish_user_paths $GOPATH/bin

function whitespace_after_prompt --on-event fish_preexec
    printf "\n"
end
