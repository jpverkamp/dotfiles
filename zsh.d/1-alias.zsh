# SSH to IU CS machines
alias cuckoo='ssh `wget -q -O - http://apps.jverkamp.com/cuckoo` -l verkampj'
alias cuckoox='ssh -X `wget -q -O - http://apps.jverkamp.com/cuckoo` -l verkampj'
alias c211='ssh tank.cs.indiana.edu -l c211'
alias c211x='ssh tank.cs.indiana.edu -l c211'
alias hulk='ssh hulk.cs.indiana.edu -l verkampj'
alias hulkx='ssh -X hulk.cs.indiana.edu -l verkampj'
alias roz='ssh roz.cs.indiana.edu -l verkampj'
alias rozx='ssh -X roz.cs.indiana.edu -l verkampj'
alias jv='ssh jverkamp.com -l verkamj'
alias jvx='ssh -X jverkamp.com -l verkamj'

# Start / stop the kerberos authentication for screen sessions
alias screen-kinit='module load screen-kinit'

# Disable autocorrect on certain commands
alias mv='nocorrect mv'       # no spelling correction on mv
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

# Too much history on DOS :-\
alias cls="clear"

# Automatically run an ls after each cd (or otherwise changing directory)
function chpwd() {
    emulate -LR zsh
    ls
}

# Special uses of rsync to do cp and mv with a progress bar
alias rscp="rsync -aP --no-whole-file --inplace"
alias rsmv="rscp --remove-source-files"

# Shortcut to rebuild using standard make setup
alias remake="make clean && make"

# Simple HTTP server
alias http="python -m SimpleHTTPServer"