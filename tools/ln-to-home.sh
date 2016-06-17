#!/bin/bash

DIR=`pwd`

echo '\
.aria2
.vimrc
.vim
.emacs.d
.gitconfig
.ycm_extra_conf.py
.tmux.conf' |
while read F; do 
  if [ -f $HOME/$F -o -d $HOME/$F ]; then 
    echo "Fail: already exists $HOME/$F";
  else 
    ln -s $DIR/$F $HOME/$F && echo "Success: created link $HOME/$F -> $DIR/$F";
  fi
done
