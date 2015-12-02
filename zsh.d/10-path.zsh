# Add a directory for any custom binaries/libraries on this machine
export PATH=$HOME/.bin:$HOME/.bin/iphone-backup:$PATH

# Set up Go
export GOPATH=~/Projects/go
export PATH=$PATH:$GOPATH/bin

# Add any custom libraries
LD_LIBRARY_PATH=$HOME/.lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
