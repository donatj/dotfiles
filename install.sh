#!/bin/sh

COLOR='\033[01;31m'	# bold red
RESET='\033[00;00m'	# normal white

OMZ=$HOME/.oh-my-zsh

DOTPATH=`dirname $0`

if [ -d "$OMZ" ]; then

	echo "oh-my-zsh found!";

	if [ ! -d "$OMZ/custom" ]; then
		echo "mkdir custom"
		mkdir $OMZ/custom
	fi

	if [ ! -d "$OMZ/custom/themes" ]; then
		echo "mkdir custom/themes"
		mkdir $OMZ/custom/themes
	fi

	cp $DOTPATH/zsh/jdonat.zsh-theme $OMZ/custom/themes

	if [ ! -d "$OMZ/custom/plugins" ]; then
		echo "mkdir custom/plugins"
		mkdir $OMZ/custom/plugins
	fi

	echo "\nInstalling ZSH Syntax Highlighting...\n"
	rm -rf $OMZ/custom/plugins/zsh-syntax-highlighting
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ/custom/plugins/zsh-syntax-highlighting

	cp $DOTPATH/zsh/.zshrc $HOME
	cp $DOTPATH/.aliases $HOME
	cp $DOTPATH/.tmux.conf $HOME


	if [ ! -d "$HOME/bin" ]; then
		mkdir $HOME/bin
	fi

	if [ ! -d "$HOME/Scripts" ]; then
		mkdir $HOME/Scripts
	fi

	RUBYPATH=`which ruby`
	if [ -x "$RUBYPATH" ]; then
		
		echo "\nInstalling Open Directory Scanner...\n"
		rm -rf $HOME/Scripts/opendir
		git clone https://gist.github.com/3285130.git $HOME/Scripts/opendir
		
	else
		printf "$COLOR - Ruby is not installed $RESET\n"
	fi

	PHPPATH=`which php`
	if [ -x "$PHPPATH" ]; then
		
		cp $DOTPATH/Scripts/argsr $HOME/Scripts
		
	else
		printf "$COLOR - PHP is not installed $RESET\n"
	fi


else
	printf "$COLOR - oh-my-zsh is not installed $RESET\n"
fi