Z_DOT_DIR=$HOME/.zsh.d/

# Load split configuration files
if [[ -d $Z_DOT_DIR ]]; then	
    for Z_FILE in `/bin/ls -1 $Z_DOT_DIR`
    do
	if [[ "$Z_FILE" == [0-9]* ]]; then
	    if [[ -a "$Z_DOT_DIR/$Z_FILE" ]]; then
		source "$Z_DOT_DIR/$Z_FILE"
	    else
		echo "Error loading $Z_DOT_DIR/$Z_FILE: file does not exist"
	    fi
	fi
    done
else
    echo "Error loading $Z_DOT_DIR: directory does not exist"
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"