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

boot2docker-reset () {
  boot2docker destroy
  boot2docker init
  boot2docker start
  $(boot2docker shellinit)
  boot2docker ssh "echo 'EXTRA_ARGS=\"--insecure-registry registry.edmodo.io\"' | sudo tee -a /var/lib/boot2docker/profile"
  boot2docker stop
  boot2docker start
}

docker-machine-reset () {
  docker-machine rm docker || true
  docker-machine create --driver virtualbox docker
  docker-machine start docker
  eval $(docker-machine env docker)
  docker-machine ssh docker "echo 'EXTRA_ARGS=\"--insecure-registry registry.edmodo.io\"' | sudo tee -a /var/lib/boot2docker/profile"
  docker-machine stop docker
  docker-machine start docker
}
