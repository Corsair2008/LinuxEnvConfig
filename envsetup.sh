#!/bin/sh

CURDIR=`pwd`

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

# install Monaco Font
FONT_DIR=/usr/share/fonts/truetype/monaco/

sudo mkdir -p $FONT_DIR
sudo cp $CURDIR/Monaco_Linux.ttf $FONT_DIR
sudo fc-cache -fv
