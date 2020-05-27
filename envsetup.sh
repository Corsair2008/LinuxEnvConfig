#!/bin/sh

CURDIR=`pwd`

import_config()
{
	# backup vimrc
	if [ -f ~/.vimrc ]
	then
		mv ~/.vimrc ~/.vimrc.backup
	fi

	ln -sf $CURDIR/vimrc ~/.vimrc
	ln -sf $CURDIR/vimrc.bundles ~/.vimrc.bundles

	# backup bashrc
	if [ -f ~/.bashrc ]
	then
		mv ~/.bashrc ~/.bashrc.backup
	fi

	ln -sf $CURDIR/bashrc ~/.bashrc
	ln -sf $CURDIR/tmux.conf ~/.tmux.conf
}

install_font()
{
	# install Monaco Font
	if [ x$1 != x ]; then FONT_DIR=$1; else	FONT_DIR=/usr/share/fonts/truetype/monaco/; fi

	sudo mkdir -p $FONT_DIR
	sudo cp $CURDIR/Monaco_Linux.ttf $FONT_DIR
	sudo fc-cache -fv
}

while getopts "f" opt; do
	case $opt in
	f)
		install_font ;;
	esac
done

import_config

