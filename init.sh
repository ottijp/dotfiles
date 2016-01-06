#!/usr/bin/env bash

ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.xvimrc ~/.xvimrc
ln -snf ~/dotfiles/.vimperatorrc ~/.vimperatorrc
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf

mkdir -p ~/vimbackup
mkdir -p ~/.vim
ln -snf ~/dotfiles/colors ~/.vim/colors

cat .bashrc_diff >> ~/.bashrc

