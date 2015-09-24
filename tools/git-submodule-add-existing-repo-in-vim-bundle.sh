#!/bin/sh

DIR=$HOME/dotfiles
cd $DIR;

ls .vim/bundle |
while read F; do 
  (cd ".vim/bundle/$F"; 
   GITURL=`git remote -v| sed -nE 's/^origin[[:blank:]]*(.*)[ ]\(fetch\)$/\1/p'`;

   cd $DIR;
   # git submodule add $GITURL ".vim/bundle/$F";
   echo "$GITURL --- $F"
  );
done
