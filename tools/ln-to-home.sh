#!/bin/bash

DIR=`pwd`

echo '.vimrc
.vim
.emacs.d
.gitconfig
.tmux.conf' | while read F; do 
  [ -f $HOME/$F -o -d $HOME/$F ] && echo "Fail: already exists $HOME/$F" || (ln -s $DIR/$F $HOME/$F && echo "Success: created link $HOME/$F -> $DIR/$F")
done
