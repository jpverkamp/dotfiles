# Disable autocorrect on certain commands
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# Make ls colorful if possible
if ls -F --color=auto >&/dev/null; then
  alias ls="ls --color=auto -F"
else
  alias ls="ls -F"
fi

# Shortcuts for moving/making directories
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'

# Never use emacs window
alias em="emacs -nw"

# Use vim
alias vi="vim"

# Special uses of rsync to do cp and mv with a progress bar
alias rscp="rsync -aP --no-whole-file --inplace"
alias rsmv="rscp --remove-source-files"

# Shortcut to rebuild using standard make setup
alias remake="make clean && make"

# Shortcut for the blog
alias blog="racket ~/Projects/blog-generator/blog.rkt"

# Simple HTTP server
alias http="python -m SimpleHTTPServer"

# Docker aliases
docker-kill-all () { docker ps -q | xargs docker kill }
docker-bash () { docker exec -it $(docker ps -q | head -n 1) bash }
docker-nuke () {
  docker-kill-all
  docker images | grep '<none>' | awk '{print $3;}' | xargs docker rmi -f;
  docker rm -v $(docker ps -a -q -f status=exited);
  docker rmi $(docker images -f "dangling=true" -q);
}

docker-machine-reset () {
  docker-machine rm dev || true
  docker-machine create --driver virtualbox --engine-insecure-registry registry.edmodo.io dev
  docker-machine start dev
  eval $(docker-machine env dev)
}

# selecta based aliases
# source: https://gist.github.com/neilberget/1588f136847ed40afcd4

# Kill a process
alias zap="ps aux | tail -n+2 | selecta | tr -s ' ' | cut -d ' ' -f 2 | xargs kill"
alias zap9="ps aux | tail -n+2 | selecta | tr -s ' ' | cut -d ' ' -f 2 | xargs kill -9"

# cd into an arbitrarily deep subdirectory. Don't try in directories with too many subdirectories (e.g. $HOME)
alias sd='cd $(find * -type d | selecta)'

# Docker shortcuts
alias dpicker="docker ps | tail -n+2 | selecta | cut -d' ' -f1"
alias dbash="dpicker | xargs -I HASH exec -it HASH bash"
alias dstop="dpicker | xargs docker rm -f"
alias dtail="dpicker | xargs docker logs -f"
alias dtop="dpicker | xargs docker top"
alias dinspect="dpicker | xargs docker inspect"

# Run a make target
maketargets() {
  make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}'
}
alias makes="maketargets | selecta | xargs make"

# OSX specific aliases
if [[ `uname` == 'Darwin' ]]
then
    alias atom="/Applications/Atom.app/Contents/MacOS/Atom"
    alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"

    # https://apple.stackexchange.com/questions/15318/using-terminal-to-copy-a-file-to-clipboard
    pbcopy-file() {
        osascript \
            -e 'on run args' \
            -e 'set the clipboard to POSIX file (first item of args)' \
            -e 'end' \
            "$@"
    }

    gif() {
        pbcopy-file "`find ~/Dropbox/gifs -type f | selecta`"
    }

    pbuni() {
        uni $@ | selecta | cut -f 1 | tr -d '\n' | pbcopy
    }
fi
