# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

HISTSIZE=1000000
SAVEHIST=$HISTSIZE

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

plugins=(git zsh-syntax-highlighting composer brew phing gem golang docker npm)

source "$HOME/.dotfiles.zshrc"

# Load my local zsh_rc
if [ -f "$HOME/.local.zshrc" ]; then
    source "$HOME/.local.zshrc"
fi

source "$ZSH/oh-my-zsh.sh"
unsetopt correct_all
setopt NO_BEEP

# Make composer STFU about XDEBUG
export COMPOSER_DISABLE_XDEBUG_WARN=1

# Load my Aliases
source $HOME/.aliases

if [ -f "$HOME/.go.crosscompile.zshrc" ]; then
    source $HOME/.go.crosscompile.zshrc
fi

if [ -f "$HOME/.local.aliases" ]; then
    source $HOME/.local.aliases
fi

if [[ "$OSTYPE" == darwin* ]]; then
    source $HOME/.darwin.zshrc
fi

if [ -x /usr/libexec/path_helper ]; then
    eval $(/usr/libexec/path_helper -s)
fi

if [ -f "$HOME/.local.paths" ]; then
    source "$HOME/.local.paths"
fi

# If subl doesn't exist, map it to vim
which subl &> /dev/null
if [ $? -ne 0 ]; then
    function subl() { /usr/bin/vim "$@" ;}
fi