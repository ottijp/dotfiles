#!/usr/bin/env bash

# deploy dotfiles

mkdir -p ~/.hammerspoon
mkdir -p ~/vimbackup
mkdir -p ~/.vim
mkdir -p ~/.docker

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -snf ~/dotfiles/$f ~/$f
done

ln -snf ~/dotfiles/.hammerspoon/init.lua ~/.hammerspoon/init.lua
ln -snf ~/dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml
ln -snf ~/dotfiles/colors ~/.vim/colors
ln -snf ~/dotfiles/.docker/config.json ~/.docker/config.json


# bash git completion

if [ ! -f ~/.git-completion.bash ]; then
  curl -L -o ~/.git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
fi
if [ ! -f ~/.git-prompt.sh ]; then
  curl -L -o ~/.git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
  chmod +x ~/.git-prompt.sh
fi


# zsh git completion

ZSH_COMPLETION_PATH=~/.zsh/completion
mkdir -p $ZSH_COMPLETION_PATH
if [ ! -f $ZSH_COMPLETION_PATH/git-completion.bash ]; then
  curl -L -o $ZSH_COMPLETION_PATH/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
fi
if [ ! -f $ZSH_COMPLETION_PATH/_git ]; then
  curl -L -o $ZSH_COMPLETION_PATH/_git https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
fi
if [ ! -f $ZSH_COMPLETION_PATH/git-prompt.sh ]; then
  curl -L -o $ZSH_COMPLETION_PATH/git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
fi
rm -f ~/.zcompdump
which compinit && compinit
