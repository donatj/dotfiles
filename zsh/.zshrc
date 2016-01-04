# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jdonat"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting composer brew gem)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all
setopt NO_BEEP

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin:/usr/local/sbin

export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/Scripts/opendir:$HOME/Scripts/cp-branch
export PATH=$PATH:$HOME/bin:$HOME/Scripts

export PATH=$PATH:$HOME/.composer/vendor/bin:$HOME/pear/bin

# Load my Aliases
source $HOME/.aliases

if [ -f "$HOME/.go.crosscompile.zshrc" ]; then
    source $HOME/.go.crosscompile.zshrc
fi

# Load my local zsh_rc
if [ -f "$HOME/.local.zshrc" ]; then
    source $HOME/.local.zshrc
fi

if [ -f "$HOME/.local.aliases" ]; then
    source $HOME/.local.aliases
fi

# If subl doesn't exist, map it to vim
which subl &> /dev/null
if [ $? -ne 0 ]; then
    function subl() { /usr/bin/vim "$@" ;}
fi

if [[ "$OSTYPE" == darwin* ]]; then
    # Show man page in Preview.app.
    # $ manp cd
    function manp {
        local page
        if (( $# > 0 )); then
            for page in "$@"; do
                man -t "$page" | open -f -a Preview
            done
        else
            print 'What manual page do you want?' >&2
        fi
    }

    # Show current Finder directory.
    function finder {
        osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}
fi

# Tell the terminal about the working directory whenever it changes.
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then

    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL, including
        # the host name to disambiguate local vs. remote paths.

        # Percent-encode the pathname.
        local URL_PATH=''
        {
            # Use LANG=C to process text byte-by-byte.
            local i ch hexch LANG=C
            for ((i = 1; i <= ${#PWD}; ++i)); do
                ch="$PWD[i]"
                if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                    URL_PATH+="$ch"
                else
                    hexch=$(printf "%02X" "'$ch")
                    URL_PATH+="%$hexch"
                fi
            done
        }

        local PWD_URL="file://$HOST$URL_PATH"
        #echo "$PWD_URL"        # testing
        printf '\e]7;%s\a' "$PWD_URL"
    }

    # Register the function so it is called whenever the working
    # directory changes.
    autoload add-zsh-hook
    add-zsh-hook chpwd update_terminal_cwd

    # Tell the terminal about the initial directory.
    update_terminal_cwd
fi
