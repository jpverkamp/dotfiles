set __fish_git_prompt_color_branch blue

set -gx fish_user_paths ~/.bin ~/.work-bin ~/go/bin
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

set -g fish_user_paths ~/.cargo/bin $fish_user_paths
set -g fish_user_paths "/opt/homebrew/bin/" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/lib/ruby/gems/2.7.0/bin" $fish_user_paths
set -g fish_user_paths "/Library/Frameworks/Mono.framework/Versions/Current/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/opt/python@3.9/libexec/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/opt/openjdk/bin" $fish_user_paths

# export a default region so you don't need to reference it all the time:
set -gx AWS_DEFAULT_REGION "us-east-1"
## create aliases for the aws cli command
# straight AWS CLI
alias awscurrent="AWS_PROFILE=current aws"
alias awsdev="AWS_PROFILE=development aws"
alias awsprod="AWS_PROFILE=production aws"
alias awstools="AWS_PROFILE=tools aws"
alias awsstaging="AWS_PROFILE=staging aws"
# kubernetes commands
alias configkdev="AWS_PROFILE=development aws eks update-kubeconfig --name development --alias development"
alias kdev="AWS_PROFILE=development kubectl --context development"
alias configkstaging="AWS_PROFILE=staging aws eks update-kubeconfig --name staging --alias staging"
alias kstaging="AWS_PROFILE=staging kubectl --context staging"
alias configkprod="AWS_PROFILE=production aws eks update-kubeconfig --name production --alias production"
alias kprod="AWS_PROFILE=production kubectl --context production"
alias configktools="AWS_PROFILE=tools aws eks update-kubeconfig --name tools --alias tools"
alias ktools="AWS_PROFILE=tools kubectl --context tools"
# stern commands
alias sternstaging="AWS_PROFILE=staging stern --context staging"
alias sterndev="AWS_PROFILE=development stern --context development"
alias sternprod="AWS_PROFILE=production stern --context production"
alias sterntools="AWS_PROFILE=tools stern --context tools"

# sops commands
alias sopsstaging="AWS_PROFILE=128474424714-administrative_access sops"
alias sopsdev="AWS_PROFILE=023960110322-administrative_access sops"
alias sopsprod="AWS_PROFILE=491026107560-administrative_access sops"
alias sopstools="AWS_PROFILE=588240676032-administrative_access sops"
# helm commands
alias helmstaging="AWS_PROFILE=128474424714-administrative_access helm --kube-context staging"
alias helmdev="AWS_PROFILE=023960110322-administrative_access helm --kube-context development"
alias helmprod="AWS_PROFILE=491026107560-administrative_access helm --kube-context production"
alias helmtools="AWS_PROFILE=588240676032-administrative_access helm --kube-context tools"
# velero commands
alias vstaging="AWS_PROFILE=128474424714-administrative_access velero --kubecontext staging"
alias vdev="AWS_PROFILE=023960110322-administrative_access velero --kubecontext development"
alias vprod="AWS_PROFILE=491026107560-administrative_access velero --kubecontext production"
alias vtools="AWS_PROFILE=588240676032-administrative_access velero --kubecontext tools"
# terragrunt commands
alias tgstaging="AWS_PROFILE=128474424714-administrative_access terragrunt"
alias tgdev="AWS_PROFILE=023960110322-administrative_access terragrunt"
alias tgprod="AWS_PROFILE=491026107560-administrative_access terragrunt"
alias tgtools="AWS_PROFILE=588240676032-administrative_access terragrunt"
# terraform commands
alias tfstaging="AWS_PROFILE=128474424714-administrative_access terraform"
alias tfdev="AWS_PROFILE=023960110322-administrative_access terraform"
alias tfprod="AWS_PROFILE=491026107560-administrative_access terraform"
alias tftools="AWS_PROFILE=588240676032-administrative_access terraform"
alias tfcurrent="AWS_PROFILE=getethos-administrative_access terraform"
