#!/usr/bin/env bash

readonly SCRIPT_DIR=$(cd $(dirname "$0"); pwd)
readonly XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
readonly XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
mkdir -p "$XDG_CONFIG_HOME"

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
  local target="${2:-$HOME/$1}"
  local src="$SCRIPT_DIR/$1"

  echo "create link: $target -> $src"
  mkdir -p "$(dirname "$target")"
  ln -snf "$src" "$target"
}

function create_config_link() {
  local target="${2:-$XDG_CONFIG_HOME/$1}"
  local src="$SCRIPT_DIR/.config/$1"

  echo "create link: $target -> $src"
  mkdir -p "$(dirname "$target")"
  ln -snf "$src" "$target"
}

# deploy dotfiles

# create_link .bashrc
# create_link .ctags
# create_link .eslintrc.json
create_link .gvimrc
create_link .inputrc
create_link .iterm2
create_link .vsnip
create_link .zprofile
create_link .zshenv

create_link bin
create_link templates

create_config_link git/config
create_config_link git/gitignore_global
create_config_link tmux/tmux.conf
create_config_link zsh
create_config_link ranger
# for .tig_history
mkdir -p "$XDG_DATA_HOME/tig"
create_config_link tig/config

if is_osx; then
  create_link .hammerspoon/init.lua
  create_config_link karabiner/assets/complex_modifications/terminal-disable-shortcut.json
fi

# vim
create_config_link vim/vimrc
create_config_link vim/after
create_config_link vim/filetype.vim
create_config_link vim/ftdetect
create_config_link vim/ftplugin
create_config_link vim/dein
create_config_link vim/vimrc "$XDG_CONFIG_HOME/nvim/init.vim"
create_config_link vim/nvim_vscode

# pandoc
create_config_link pandoc

# vscode
if is_osx; then
  create_link vscode_keybindings.json "$HOME/Library/Application Support/Cursor/User/keybindings.json"
fi

# bash git completion

# if [ ! -f ~/.git-completion.bash ]; then
#   curl -L -o ~/.git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
# fi
# if [ ! -f ~/.git-prompt.sh ]; then
#   curl -L -o ~/.git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
#   chmod +x ~/.git-prompt.sh
# fi


# zsh git completion

ZSH_COMPLETION_PATH=$XDG_CONFIG_HOME/zsh/completion
ZSH_MISC_PATH=$XDG_CONFIG_HOME/zsh/misc
mkdir -p "$ZSH_COMPLETION_PATH"
if [ ! -f "$ZSH_COMPLETION_PATH/git-completion.bash" ]; then
  curl -L -o "$ZSH_COMPLETION_PATH/git-completion.bash" https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
fi
if [ ! -f "$ZSH_COMPLETION_PATH/_git" ]; then
  curl -L -o "$ZSH_COMPLETION_PATH/_git" https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
fi
if [ ! -f "$ZSH_MISC_PATH/git-prompt.sh" ]; then
  curl -L -o "$ZSH_MISC_PATH/git-prompt.sh" https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
fi
rm -f ~/.zcompdump
type compinit >/dev/null 2>&1 && compinit

