#!/usr/bin/env bash

# deployment
mkdir -p ~/.hammerspoon
mkdir -p ~/vimbackup
mkdir -p ~/.vim

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


# init
curl -L -o ~/.git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
curl -L -o ~/.git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
chmod +x ~/.git-prompt.sh
ZSH_COMPLETION_PATH=~/.zsh/completion
mkdir -p $ZSH_COMPLETION_PATH
curl -L -o $ZSH_COMPLETION_PATH/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
curl -L -o $ZSH_COMPLETION_PATH/_git https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
curl -L -o $ZSH_COMPLETION_PATH/git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
rm -f ~/.zcompdump
which compinit && compinit
