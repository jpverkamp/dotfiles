[1mdiff --git a/zsh.d/2-repo-symbols.zsh b/zsh.d/2-repo-symbols.zsh[m
[1mdeleted file mode 100644[m
[1mindex 66bcda5..0000000[m
[1m--- a/zsh.d/2-repo-symbols.zsh[m
[1m+++ /dev/null[m
[36m@@ -1,4 +0,0 @@[m
[31m-Z_REPO_ALL_GOOD="✓"[m
[31m-Z_REPO_NEW_FILES="⁂"                                                                      [m
[31m-Z_REPO_CHANGES="✗"                                                                      [m
[31m-Z_REPO_UNKNOWN="⁇" [m
[1mdiff --git a/zsh.d/3-git.zsh b/zsh.d/3-git.zsh[m
[1mdeleted file mode 100644[m
[1mindex a93c02e..0000000[m
[1m--- a/zsh.d/3-git.zsh[m
[1m+++ /dev/null[m
[36m@@ -1,47 +0,0 @@[m
[31m-# Flag if the git display needs to be updated[m
[31m-Z_GIT_UPDATE=1[m
[31m-Z_GIT=""[m
[31m-[m
[31m-# Update the git prompt (if necessary)[m
[31m-function zsh_git_prompt_precmd {[m
[31m-	if [[ -n "$Z_GIT_UPDATE" ]] ; then[m
[31m-		local git_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')[m
[31m-[m
[31m-		if [[ -n $git_branch ]]; then[m
[31m-			local git_status="`git status 2>/dev/null`"[m
[31m-			local git_char=""[m
[31m-[m
[31m-			if [[ $git_status =~ nothing\ to\ commit ]]; then[m
[31m-					git_char=" $Z_REPO_ALL_GOOD"[m
[31m-			elif [[ $git_status =~ ntracked\ files ]]; then[m
[31m-					git_char=" $Z_REPO_NEW_FILES"[m
[31m-			elif [[ $git_status =~ Changes\ to\ be\ committed || $git_status =~ no\ changes\ added\ to\ commit ]]; then[m
[31m-					git_char=" $Z_REPO_CHANGES"[m
[31m-			else [m
[31m-					git_char=" $Z_REPO_UNKNOWN"[m
[31m-			fi[m
[31m-			Z_GIT=" %{$Z_CLR_RESET%}(git %{$Z_CLR_GREEN%}$git_branch%{$Z_CLR_YELLOW%}$git_char%{$Z_CLR_RESET%})"[m
[31m-		else[m
[31m-			Z_GIT=""[m
[31m-    fi[m
[31m-		Z_GIT_UPDATE=""[m
[31m-	fi[m
[31m-}[m
[31m-precmd_functions+='zsh_git_prompt_precmd'[m
[31m-[m
[31m-# Flag update on directory change[m
[31m-function zsh_git_prompt_chpwd {[m
[31m-	Z_GIT_UPDATE=1[m
[31m-}[m
[31m-chpwd_functions+='zsh_git_prompt_chpwd'[m
[31m-[m
[31m-# Flag update on GIT commands[m
[31m-function zsh_git_prompt_preexec {[m
[31m-  case "$(history $HISTCMD)" in [m
[31m-	  *git*)[m
[31m-			Z_GIT_UPDATE=1[m
[31m-			;;[m
[31m-  esac[m
[31m-}[m
[31m-preexec_functions+='zsh_git_prompt_preexec'[m
[31m-[m
[1mdiff --git a/zsh.d/4-prompt.zsh b/zsh.d/4-prompt.zsh[m
[1mindex 3f5233d..18bc778 100644[m
[1m--- a/zsh.d/4-prompt.zsh[m
[1m+++ b/zsh.d/4-prompt.zsh[m
[36m@@ -1,13 +1,34 @@[m
[32m+[m[32m# Add current repo info to the prompt[m
[32m+[m[32mautoload -Uz vcs_info[m
[32m+[m[32mzstyle ':vcs_info:*' enable git svn[m
[32m+[m[32mzstyle ':vcs_info:git*' formats "%{$Z_CLR_BLUE%}%s %b%{$Z_CLR_RESET%}%m%u%c"[m
[32m+[m
[32m+[m[32mlocal Z_DATE="%D{%Y-%m-%d %H:%M}"[m
[32m+[m[32mlocal Z_DIRECTORY="%{$Z_CLR_GREEN%}%~%{$Z_CLR_RESET%}"[m
[32m+[m[32mlocal Z_MACHINE="%{$Z_CLR_MAGENTA%}%n%{$Z_CLR_RESET%}@%{$Z_CLR_YELLOW%}%m%{$Z_CLR_RESET%}"[m
[32m+[m[32mlocal Z_STATUS="%(?,%{$Z_CLR_GREEN%}^_^%f%b,%{$Z_CLR_RED%};_;%f%b)"[m
[32m+[m[32mlocal Z_VCS=""[m
[32m+[m
[32m+[m[32mprecmd() {[m
[32m+[m[32m    vcs_info[m
[32m+[m[32m    echo "run"[m
[32m+[m[32m    if [[ -n ${vcs_info_msg_0_} ]]; then[m
[32m+[m[32m        Z_VCS="{${vcs_info_msg_0_}} "[m
[32m+[m[32m    else[m
[32m+[m[32m        Z_VCS=""[m
[32m+[m[32m    fi[m
[32m+[m[32m}[m
[32m+[m
 # Automatically run an ls after each cd (or otherwise changing directory)[m
 function chpwd() {[m
     emulate -LR zsh[m
     ls[m
 }[m
 [m
[31m-# Prompt may change[m
[32m+[m[32m# Control the prompt(s)[m
 function zsh_update_prompt {[m
[31m-    PROMPT="[m
[31m-┌ ☺ %{$Z_CLR_MAGENTA%}%n%{$Z_CLR_RESET%}@%{$Z_CLR_YELLOW%}%m$Z_GIT$Z_SVN %{$Z_CLR_GREEN%}%~%{$Z_CLR_RESET%}[m
[32m+[m[32mPROMPT="[m
[32m+[m[32m┌ ${Z_STATUS} ${Z_MACHINE} ${Z_VCS}${Z_DIRECTORY}[m
 └ "[m
 }[m
 precmd_functions+='zsh_update_prompt'[m
