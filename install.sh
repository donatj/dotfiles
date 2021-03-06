#!/bin/bash

set -e

_mv_file_rm_sym () {
	if [ -f "$1" ]; then
		if [ ! -h "$1" ]; then
			echo "Moving old $1 ...";
			mv "$1" "$1.old.$(date +"%s")"
		else
			echo "Removing old $1 symlink ..."
			rm "$1"
		fi
	else
		echo "Doesn't exist - skipping"
	fi
}

_no_folder_create() {
	if [ ! -d "$1" ]; then
		echo "mkdir $1 ..."
		mkdir "$1"
	fi
}

_cfg_ln(){
	_mv_file_rm_sym "$2"
	ln -s "$1" "$2"
}

GREEN='\033[01;32m'
PURPL='\033[01;35m'
RED='\033[01;31m'
RESET='\033[00;00m'

OMZ=$HOME/.oh-my-zsh

STARTPWD=$(pwd)
cd "$(dirname "$0")"
DOTPATH=$(pwd)
cd "$STARTPWD"

chsh -s /bin/zsh

echo "PATH=\$PATH:$DOTPATH/bin" > "$HOME/.zshrc.dotfiles"

[ ! -d "$OMZ" ] && wget --no-check-certificate http://install.ohmyz.sh -O - | sh

if [ -d "$OMZ" ]; then

	printf "===$PURPL Configuring Git                       $RESET===\n"

	git config --global --replace-all include.path "dotfiles/git/.gitconfig"
	if [[ "$OSTYPE" == darwin* ]]; then
		git config --global credential.helper osxkeychain
	fi

	_cfg_ln "$DOTPATH/git/.gitignore_global" "$HOME/.gitignore_global"

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ---


	printf "===$PURPL Installing/Replacing Config Files     $RESET===\n"

	_cfg_ln "$DOTPATH/zsh/.zshrc" "$HOME/.zshrc"
	_cfg_ln "$DOTPATH/zsh/.zshenv" "$HOME/.zshenv"
	_cfg_ln "$DOTPATH/zsh/.zshrc.darwin" "$HOME/.zshrc.darwin"
	_cfg_ln "$DOTPATH/.aliases" "$HOME/.aliases"
	_cfg_ln "$DOTPATH/.go.crosscompile.zshrc" "$HOME/.go.crosscompile.zshrc"
	_cfg_ln "$DOTPATH/.tmux.conf" "$HOME/.tmux.conf"
	_cfg_ln "$DOTPATH/.ttouch" "$HOME/.ttouch"

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ---


	printf "===$PURPL Creating ~/bin and ~/Scripts          $RESET===\n"

	_no_folder_create "$HOME/bin"
	_no_folder_create "$HOME/Scripts"

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ------


	printf "===$PURPL Installing ZSH Theme                  $RESET===\n"

	_no_folder_create "$OMZ/custom"
	_no_folder_create "$OMZ/custom/themes"

	_cfg_ln "$DOTPATH/zsh/jdonat.zsh-theme" "$OMZ/custom/themes/jdonat.zsh-theme"

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ------


	printf "===$PURPL Installing ZSH Syntax Highlighting    $RESET===\n"

	_no_folder_create "$OMZ/custom/plugins"

	rm -rf "$OMZ/custom/plugins/zsh-syntax-highlighting"
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git "$OMZ/custom/plugins/zsh-syntax-highlighting"

	printf "===$GREEN                  Done                 $RESET===\n\n"

	# ---

	PHPPATH=$(which php)
	if [ -x "$PHPPATH" ]; then

		printf "===$PURPL Installing composer                   $RESET===\n"

		curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin/
		rm -f $HOME/Scripts/composer
		ln -s `which composer.phar` $HOME/Scripts/composer

		_no_folder_create $OMZ/custom/plugins/composer
		_cfg_ln $DOTPATH/zsh/composer/composer.plugin.zsh $OMZ/custom/plugins/composer/composer.plugin.zsh

		printf "===$GREEN                  Done                 $RESET===\n\n"
		
	else
		printf "$RED - PHP is not installed $RESET\n"
	fi

else
	printf "$RED - oh-my-zsh is not installed $RESET\n"
fi

if [[ "$OSTYPE" == darwin* ]]; then

	printf "===$PURPL Running OS X Configuration            $RESET===\n"

	_cfg_ln "$DOTPATH/LocalDictionary" "$HOME/Library/Spelling/LocalDictionary"
	sh "$DOTPATH/.osx"

	printf "===$GREEN                  Done                 $RESET===\n\n"

fi
