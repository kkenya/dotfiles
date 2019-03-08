#!/bin/bash

DOTFILES=(.bashrc .bash_profile .vimrc .inputrc)

for file in ${DOTFILES[@]}
do 
    ln -s $HOME/dotfiles/$file $HOME/$file
done
