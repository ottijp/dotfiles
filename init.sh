#!/usr/bin/env bash

script_dir=$(cd $(dirname "$0"); pwd)
config_home=${XDG_CONFIG_HOME:-$HOME/.config}
mkdir -p $config_home

function is_osx() {
  case ${OSTYPE} in
    darwin*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

function link_files() {
  for f in $*
  do
      [[ "$f" == ".git" ]] && continue
      [[ "$f" == ".gitignore" ]] && continue
      [[ "$f" == ".DS_Store" ]] && continue

      ln -snf "$script_dir/$f" ~/$f
  done
}

# deploy dotfiles

if is_osx; then
  mkdir -p ~/.hammerspoon
fi

link_files '.??*'
link_files bin
link_files templates
link_files .vsnip

if is_osx; then
  ln -snf "$script_dir/.hammerspoon/init.lua" ~/.hammerspoon/init.lua
  ln -snf "$script_dir/karabiner/terminal-disable-shortcut.json" $config_home/karabiner/assets/complex_modifications/terminal-disable-shortcut.json
fi

# vim
mkdir -p $config_home/vim
ln -snf "$script_dir/vim/vimrc" $config_home/vim/vimrc
ln -snf "$script_dir/vim/after" $config_home/vim/after
ln -snf "$script_dir/vim/filetype.vim" $config_home/vim
ln -snf "$script_dir/vim/ftdetect" $config_home/vim
ln -snf "$script_dir/vim/ftplugin" $config_home/vim
ln -snf "$script_dir/vim/dein" $config_home/vim
mkdir -p $config_home/nvim
ln -snf $config_home/vim/vimrc $config_home/nvim/init.vim

ln -sf "$script_dir/ranger" $config_home

# pandoc
mkdir -p ~/.pandoc
ln -snf "$script_dir/templates/pandoc" ~/.pandoc/templates

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
type compinit >/dev/null 2>&1 && compinit

