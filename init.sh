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

function create_link() {
  local src="${2:-$HOME/$1}"
  local dest="$script_dir/$1"

  echo "create link: $src -> $dest"
  ln -snf "$dest" "$src"
}

function create_config_link() {
  local src="${2:-$config_home/$1}"
  local dest="$script_dir/.config/$1"

  echo "create link: $src -> $dest"
  ln -snf "$dest" "$src"
}

# deploy dotfiles

# create_link .bashrc
create_link .ctags
create_link .eslintrc.json
create_link .gitconfig
create_link .gitignore_global
create_link .gvimrc
create_link .inputrc
create_link .iterm2
create_link .tigrc
create_link .vsnip
create_link .zprofile
create_link .zshenv
create_link .zshrc

create_link bin
create_link templates

create_config_link tmux/tmux.conf
create_config_link zsh
create_config_link ranger

if is_osx; then
  mkdir -p ~/.hammerspoon
  create_link .hammerspoon/init.lua
  create_config_link karabiner/assets/complex_modifications/terminal-disable-shortcut.json
fi

# vim
mkdir -p $config_home/vim
create_config_link vim/vimrc
create_config_link vim/after
create_config_link vim/filetype.vim
create_config_link vim/ftdetect
create_config_link vim/ftplugin
create_config_link vim/dein
mkdir -p $config_home/nvim
create_config_link vim/vimrc $config_home/nvim/init.vim

# pandoc
mkdir -p ~/.pandoc
create_link templates/pandoc $HOME/.pandoc/templates

# bash git completion

# if [ ! -f ~/.git-completion.bash ]; then
#   curl -L -o ~/.git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
# fi
# if [ ! -f ~/.git-prompt.sh ]; then
#   curl -L -o ~/.git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
#   chmod +x ~/.git-prompt.sh
# fi


# zsh git completion

ZSH_COMPLETION_PATH=$config_home/zsh/completion
ZSH_MISC_PATH=$config_home/zsh/misc
mkdir -p $ZSH_COMPLETION_PATH
if [ ! -f $ZSH_COMPLETION_PATH/git-completion.bash ]; then
  curl -L -o $ZSH_COMPLETION_PATH/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
fi
if [ ! -f $ZSH_COMPLETION_PATH/_git ]; then
  curl -L -o $ZSH_COMPLETION_PATH/_git https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
fi
if [ ! -f $ZSH_MISC_PATH/git-prompt.sh ]; then
  curl -L -o $ZSH_MISC_PATH/git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
fi
rm -f ~/.zcompdump
type compinit >/dev/null 2>&1 && compinit

