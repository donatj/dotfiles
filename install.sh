#!/bin/sh

_mv_file_rm_sym () {
	if [ -f $1 ]; then
		if [ ! -h $1 ]; then
			echo "Moving old $1 ...";
			mv $1 $1.old.`date +"%s"`
		else
			echo "Removing old $1 symlink ..."
			rm $1
		fi
	else
		echo "Doesn't exist - skipping"
	fi
}

_no_folder_create() {
	if [ ! -d $1 ]; then
		echo "mkdir $1 ..."
		mkdir $1
	fi
}

GREEN='\033[01;32m'	#  purpLle
PURPL='\033[01;35m'	#  purpLle
RED='\033[01;31m'	#  red
RESET='\033[00;00m'	# normal white

OMZ=$HOME/.oh-my-zsh

STARTPWD=`pwd`
cd `dirname $0`
DOTPATH=`pwd`
cd $STARTPWD

if [ -d "$OMZ" ]; then

	printf "===$PURPL Installing/Replacing Config Files     $RESET===\n"

	_mv_file_rm_sym $HOME/.zshrc
	ln -s $DOTPATH/zsh/.zshrc $HOME/.zshrc

	_mv_file_rm_sym $HOME/.aliases
	ln -s $DOTPATH/.aliases $HOME/.aliases

	_mv_file_rm_sym $HOME/.tmux.conf;
	ln -s $DOTPATH/.tmux.conf $HOME/.tmux.conf

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ---


	printf "===$PURPL Creating ~/bin and ~/Scripts          $RESET===\n"

	_no_folder_create $HOME/bin
	_no_folder_create $HOME/Scripts

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ------


	printf "===$PURPL Installing ZSH Theme                  $RESET===\n"

	_no_folder_create $OMZ/custom
	_no_folder_create $OMZ/custom/themes

	_mv_file_rm_sym $OMZ/custom/themes/jdonat.zsh-theme;
	ln -s $DOTPATH/zsh/jdonat.zsh-theme $OMZ/custom/themes/jdonat.zsh-theme

	printf "===$GREEN                  Done                 $RESET===\n\n"


	# ------


	printf "===$PURPL Installing ZSH Syntax Highlighting    $RESET===\n"

	_no_folder_create $OMZ/custom/plugins

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

		_mv_file_rm_sym $HOME/Scripts/argsr;
		ln -s $DOTPATH/Scripts/argsr $HOME/Scripts/argsr

		printf "===$GREEN                  Done                 $RESET===\n\n"


		# -----

		printf "===$PURPL Installing composer                   $RESET===\n"

		curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin/

		_no_folder_create $OMZ/custom/plugins/composer
		_mv_file_rm_sym $OMZ/custom/plugins/composer/composer.plugin.zsh;
		ln -s $DOTPATH/zsh/composer/composer.plugin.zsh $OMZ/custom/plugins/composer/composer.plugin.zsh

		printf "===$GREEN                  Done                 $RESET===\n\n"
		
	else
		printf "$RED - PHP is not installed $RESET\n"
	fi

	# cp $DOTPATH/Scripts/hostname_color.py $HOME/Scripts

else
	printf "$RED - oh-my-zsh is not installed $RESET\n"
fi
