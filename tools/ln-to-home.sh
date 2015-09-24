#!/bin/bash

DIR=`pwd`

echo '.vimrc
.vim
.emacs.d' | while read F; do 
  [ -f $HOME/$F -o -d $HOME/$F ] || ln -s $DIR/$F $HOME/$F;
done
