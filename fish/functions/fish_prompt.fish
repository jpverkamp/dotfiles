function fish_prompt
    set last_status $status
    printf "\n><> "

    # Different status if the last command ws successful
    if test $last_status -eq 0
        set_color green
        printf "^_^ "
    else
        set_color red
        printf ";_; "
    end

    # Where am I (current user, machine, git, and path)
    set_color purple
    printf (whoami)
    set_color white
    printf "@"
    set_color yellow
    printf (hostname -s)

    # Git status
    set git_branch (git rev-parse --abbrev-ref HEAD ^ /dev/null)
    if test "$git_branch" != ""
        set_color white
        printf " {"
        set_color blue
        printf "git $git_branch"
        set_color white
        printf "}"
    end

    set_color green
    printf " %s" (pwd)

    # Actual prompt
    set_color white
    printf "\n\$ "
end
