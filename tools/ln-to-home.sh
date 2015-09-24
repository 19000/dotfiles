#!/bin/bash

DIR=`pwd`

echo '.vimrc
.vim
.emacs.d' | while read F; do 
  ln -s $DIR/$F $HOME/$F;
done
