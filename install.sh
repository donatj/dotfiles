#!/bin/bash

set -e

secheader () {
	echo ""
	echo "##############################################################################"
	echo "#"
	echo "# $1"
	echo "#"
	echo "##############################################################################"
	echo ""
}

warn () {
	printf "\033[01;31m - %s\033[00;00m\n" "$1"
}

_mv_file_rm_sym () {
	if [ -f "$1" ] || [ -d "$1" ]; then
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


OMZ=$HOME/.oh-my-zsh

STARTPWD=$(pwd)
cd "$(dirname "$0")"
DOTPATH=$(pwd)
cd "$STARTPWD"

chsh -s /bin/zsh

echo "PATH=\$PATH:$DOTPATH/bin" > "$HOME/.dotfiles.zshrc"

[ ! -d "$OMZ" ] && wget --no-check-certificate http://install.ohmyz.sh -O - | sh

secheader "Configuring Git"

git config --global --replace-all include.path "dotfiles/git/.gitconfig"
if [[ "$OSTYPE" == darwin* ]]; then
	git config --global credential.helper osxkeychain
fi

_cfg_ln "$DOTPATH/git/.gitignore_global" "$HOME/.gitignore_global"


# ------

secheader "Installing/Replacing Config Files"

_cfg_ln "$DOTPATH/zsh/.zshrc" "$HOME/.zshrc"
_cfg_ln "$DOTPATH/zsh/.zshenv" "$HOME/.zshenv"
_cfg_ln "$DOTPATH/zsh/.darwin.zshrc" "$HOME/.darwin.zshrc"
_cfg_ln "$DOTPATH/.aliases" "$HOME/.aliases"
_cfg_ln "$DOTPATH/.go.crosscompile.zshrc" "$HOME/.go.crosscompile.zshrc"
_cfg_ln "$DOTPATH/.tmux.conf" "$HOME/.tmux.conf"
_cfg_ln "$DOTPATH/ttouch" "$HOME/.ttouch"

# ------


secheader "Creating ~/bin and ~/Scripts"

_no_folder_create "$HOME/bin"
_no_folder_create "$HOME/Scripts"

# ------


secheader "Installing ZSH Theme"

_no_folder_create "$OMZ/custom"
_no_folder_create "$OMZ/custom/themes"

_cfg_ln "$DOTPATH/zsh/jdonat.zsh-theme" "$OMZ/custom/themes/jdonat.zsh-theme"


# ------

secheader "SSH Setup"

_no_folder_create "$HOME/.ssh"
_cfg_ln "$DOTPATH/ssh/config" "$HOME/.ssh/mobile_config"

# ------

secheader "Installing ZSH Syntax Highlighting"

_no_folder_create "$OMZ/custom/plugins"

rm -rf "$OMZ/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$OMZ/custom/plugins/zsh-syntax-highlighting"


# ------


if [ -x "$(which php)" ]; then

	secheader "Installing composer"

	curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin/
	rm -f $HOME/Scripts/composer
	ln -s "$(which composer.phar)" "$HOME/Scripts/composer"

	_no_folder_create $OMZ/custom/plugins/composer
	_cfg_ln $DOTPATH/zsh/composer/composer.plugin.zsh $OMZ/custom/plugins/composer/composer.plugin.zsh

else
	warn "php is not installed, skipping section"
fi


if [[ "$OSTYPE" == darwin* ]]; then

	secheader "macOS Specific Configuration"

	_cfg_ln "$DOTPATH/LocalDictionary" "$HOME/Library/Spelling/LocalDictionary"
	sh "$DOTPATH/.osx"

	if [ -x "$(which brew)" ]; then
		secheader "Running brew install"

		sh "$DOTPATH/brew.sh"
	else
		warn "brew is not installed"
	fi

fi
