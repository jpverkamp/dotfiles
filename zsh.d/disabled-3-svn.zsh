# Flag if the svn display needs to be updated
Z_SVN_UPDATE=1
Z_SVN=""

# Update the svn prompt (if necessary)
function zsh_svn_prompt_precmd {
	if [[ -n "$Z_SVN_UPDATE" ]] ; then
		local svn_rev=$(svn info 2> /dev/null | grep "Revision" | sed 's/[^0-9]*\([0-9]*\).*/\1/')
		
    if [[ -n $svn_rev ]]; then
			local svn_status="`svn status 2>/dev/null`"
			local svn_char=""

			if [[ $svn_status =~ is\ not\ a\ working\ copy ]]; then
					svn_char=""
			elif [[ $svn_status =~ \\? ]]; then
					svn_char=" $Z_REPO_NEW_FILES"
			elif [[ $svn_status =~ ^M || $svn_status =~ ^A ]]; then
					svn_char=" $Z_REPO_CHANGES"
			elif [[ $svn_status == "" ]]; then
					svn_char=" $Z_REPO_ALL_GOOD"
			else 
					svn_char=" $Z_REPO_UNKNOWN"
			fi

			Z_SVN=" %{$Z_CLR_RESET%}(svn %{$Z_CLR_GREEN%}$svn_rev%{$Z_CLR_YELLOW%}$svn_char%{$Z_CLR_RESET%})"
	  else
	  	Z_SVN=""
	 	fi
	 	Z_SVN_UPDATE=""
	fi
}
precmd_functions+='zsh_svn_prompt_precmd'

# Flag update on directory change
function zsh_svn_prompt_chpwd {
	Z_SVN_UPDATE=1
}
chpwd_functions+='zsh_svn_prompt_chpwd'

# Flag update on SVN commands
function zsh_svn_prompt_preexec {
  case "$(history $HISTCMD)" in 
	  *svn*)
			Z_SVN_UPDATE=1
			;;
  esac
}
preexec_functions+='zsh_svn_prompt_preexec'


