# Flag if the git display needs to be updated
Z_GIT_UPDATE=1
Z_GIT=""

# Update the git prompt (if necessary)
function zsh_git_prompt_precmd {
	if [[ -n "$Z_GIT_UPDATE" ]] ; then
		local git_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

		if [[ -n $git_branch ]]; then
			local git_status="`git status 2>/dev/null`"
			local git_char=""

			if [[ $git_status =~ nothing\ to\ commit ]]; then
					git_char=" $Z_REPO_ALL_GOOD"
			elif [[ $git_status =~ ntracked\ files ]]; then
					git_char=" $Z_REPO_NEW_FILES"
			elif [[ $git_status =~ Changes\ to\ be\ committed || $git_status =~ no\ changes\ added\ to\ commit ]]; then
					git_char=" $Z_REPO_CHANGES"
			else 
					git_char=" $Z_REPO_UNKNOWN"
			fi
			Z_GIT=" %{$Z_CLR_RESET%}(git %{$Z_CLR_GREEN%}$git_branch%{$Z_CLR_YELLOW%}$git_char%{$Z_CLR_RESET%})"
		else
			Z_GIT=""
    fi
		Z_GIT_UPDATE=""
	fi
}
precmd_functions+='zsh_git_prompt_precmd'

# Flag update on directory change
function zsh_git_prompt_chpwd {
	Z_GIT_UPDATE=1
}
chpwd_functions+='zsh_git_prompt_chpwd'

# Flag update on GIT commands
function zsh_git_prompt_preexec {
  case "$(history $HISTCMD)" in 
	  *git*)
			Z_GIT_UPDATE=1
			;;
  esac
}
preexec_functions+='zsh_git_prompt_preexec'

