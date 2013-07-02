#!/bin/sh

OMZ=$HOME/.oh-my-zsh

DOTPATH=`dirname $0`

if [ -d $OMZ ]; then

	echo "oh-my-zsh found!";

	if [ ! -d $OMZ/custom ]; then
		echo "mkdir custom"
		mkdir $OMZ/custom
	fi

	if [ ! -d $OMZ/custom/themes ]; then
		echo "mkdir custom/themes"
		mkdir $OMZ/custom/themes
	fi

	cp $DOTPATH/zsh/jdonat.zsh-theme $OMZ/custom/themes

	if [ ! -d $OMZ/custom/plugins ]; then
		echo "mkdir custom/plugins"
		mkdir $OMZ/custom/plugins
	fi

	echo "Installing ZSH Syntax Highlighting..."
	rm -rf $OMZ/custom/plugins/zsh-syntax-highlighting
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ/custom/plugins/zsh-syntax-highlighting

	cp $DOTPATH/zsh/.zshrc $HOME
	cp $DOTPATH/.aliases $HOME

fi;