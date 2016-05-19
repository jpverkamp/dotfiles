set __fish_git_prompt_color_branch blue

set -U fish_user_paths $fish_user_paths ~/.bin
set -U EDITOR vim

function whitespace_after_prompt --on-event fish_preexec
    printf "\n"
end
