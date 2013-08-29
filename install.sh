#!/bin/sh

GREEN='\033[01;32m'	#  purpLle
PURPL='\033[01;35m'	#  purpLle
RED='\033[01;31m'	#  red
RESET='\033[00;00m'	# normal white

OMZ=$HOME/.oh-my-zsh

DOTPATH=`dirname $0`

if [ -d "$OMZ" ]; then

	printf "===$PURPL Installing/Replacing Config Files     $RESET===\n"

	cp $DOTPATH/zsh/.zshrc $HOME
	cp $DOTPATH/.aliases $HOME
	cp $DOTPATH/.tmux.conf $HOME

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ---


	printf "===$PURPL Creating ~/bin and ~/Scripts          $RESET===\n"

	if [ ! -d "$HOME/bin" ]; then
		mkdir $HOME/bin
	fi

	if [ ! -d "$HOME/Scripts" ]; then
		mkdir $HOME/Scripts
	fi

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ------


	printf "===$PURPL Installing ZSH Theme                  $RESET===\n"

	if [ ! -d "$OMZ/custom" ]; then
		echo "mkdir custom"
		mkdir $OMZ/custom
	fi

	if [ ! -d "$OMZ/custom/themes" ]; then
		echo "mkdir custom/themes"
		mkdir $OMZ/custom/themes
	fi

	cp $DOTPATH/zsh/jdonat.zsh-theme $OMZ/custom/themes

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ------


	printf "===$PURPL Installing ZSH Syntax Highlighting    $RESET===\n"

	if [ ! -d "$OMZ/custom/plugins" ]; then
		echo "mkdir custom/plugins"
		mkdir $OMZ/custom/plugins
	fi

	rm -rf $OMZ/custom/plugins/zsh-syntax-highlighting
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ/custom/plugins/zsh-syntax-highlighting

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ------


	RUBYPATH=`which ruby`
	if [ -x "$RUBYPATH" ]; then

		printf "===$PURPL Installing Open Directory Scanner     $RESET===\n"

		rm -rf $HOME/Scripts/opendir
		git clone git://gist.github.com/3285130.git $HOME/Scripts/opendir

		printf "===$GREEN                  Done                 $RESET===\n\n"
		
	else
		printf "$RED - Ruby is not installed $RESET\n"
	fi

	# ---

	PHPPATH=`which php`
	if [ -x "$PHPPATH" ]; then
		
		printf "===$PURPL Installing misc php scripts           $RESET===\n"

		cp $DOTPATH/Scripts/argsr $HOME/Scripts

		printf "===$GREEN                  Done                 $RESET===\n\n"


		# -----

		printf "===$PURPL Installing composer                   $RESET===\n"

		curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/

		printf "===$GREEN                  Done                 $RESET===\n\n"
		
	else
		printf "$RED - PHP is not installed $RESET\n"
	fi

	cp $DOTPATH/Scripts/hostname_color.py $HOME/Scripts

else
	printf "$RED - oh-my-zsh is not installed $RESET\n"
fi