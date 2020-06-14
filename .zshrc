# undef console output stop (enable incremental search)
stty stop undef

# avoid duplicated PATHs
typeset -U path PATH

#-----------------------------------
# functions
#-----------------------------------
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PROMPT" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
function chpwd () { ls -GF }
function mkdircd () { mkdir -p "$@" && builtin cd "$@" }

# search src with fzf
fzf-src() {
  local selected
  selected=`ghq list --full-path | fzf --query="$LBUFFER"`
  if [ -n "$selected" ]; then
    BUFFER="builtin cd $selected"
    zle accept-line
  fi
  zle reset-prompt
}

# search commands and shell functions
fzf-cmd() {
  local selected
  selected=`(for p in ${(@s/:/)PATH}; do
    find $p -depth 1 -perm +111 -type f -or -type l -follow 2>/dev/null
    done;
    print -l ${(ok)functions} | grep '^[^_]') |\
      sed 's|.*/||' | fzf --query="$LBUFFER"`
  if [ -n "$selected" ]; then
    LBUFFER="$selected "
  fi
  zle reset-prompt
}

# search bookmarks functions
fzf-bookmark() {
  local selected
  selected=`(cat ~/bookmarks 2>/dev/null) | fzf`
  if [ -n "$selected" ]; then
    LBUFFER=${LBUFFER}"`awk 'BEGIN{FS=","}{print $2}' <<<"$selected" | sed 's/ /\\\\ /g'` "
  fi
  zle reset-prompt
}


#-----------------------------------
# command alias and env vars
#-----------------------------------
# ls
alias ls="ls -GF"
alias la="ls -GFa"
alias ll="ls -GFlh"
alias lla="ls -GFalh"

# mkdir
alias mkdir='mkdir -p'

# tmux
alias tmux-changekey='tmux set-option -ag prefix C-b'
alias tmux-revertkey='tmux set-option -ag prefix C-t'
alias tmux-new-session-currentpath='tmux new-session -c "$PWD"'

# ctags
alias ctags=`brew --prefix`/bin/ctags

# git
alias gs="git status"
alias gf="git diff"

# tree
alias tree="tree -I node_modules -L 3"

# grep
alias grep="grep --color=auto"

# df
alias df="df -h"

# frequently used file
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

# tar
alias tgz="tar czvf"
alias untgz="tar xzvf"


# locale
export LC_ALL=en_US.UTF-8

# prompt
setopt PROMPT_SUBST

source ~/.zsh/completion/git-prompt.sh
export PROMPT=$'%{\e[36m%}%n@%m:%{\e[35m%}%c%{\e[0;34m%}$(__git_ps1 " (%s)")%{\e[36m%} \$%{\e[0m%} '

# command histories
export HISTFILE=~/.zhistory
touch ~/.zhistory
export HISTSIZE=10000
export SAVEHIST=9000000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt share_history
setopt hist_reduce_blanks

# report time of long task
export REPORTTIME=10

# cd completion
export DIRSTACKSIZE=100
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# local bin path
export PATH=$PATH:~/bin:~/bin.local

# editor for osx
MACVIM_PATH="/Applications/MacVim.app"
if is_osx and [ -f "$MACVIM_PATH" ]; then
  export EDITOR="$MACVIM_PATH/Contents/MacOS/Vim"
  alias vi='env LANG=ja_JP.UTF-8 '"$MACVIM_PATH"'/Contents/MacOS/Vim "$@"'
  alias vim='env LANG=ja_JP.UTF-8 '"$MACVIM_PATH"'/Contents/MacOS/Vim "$@"'
fi

# Go lang
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME
export GOBIN=$HOME/bin.local/go
export PATH=$PATH:$GOBIN

# vifm
export MYVIFMRC=~/.vifmrc

# less
# invert only current hit, ignore case, detail prompt, ANSI color, highlight new line, window size -5
export LESS='-g -i -M -R -W -z-5'

#-----------------------------------
# Key bindings
#-----------------------------------
bindkey -v
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
#bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
#bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank
zle -N fzf-src
bindkey '^Xs' fzf-src
zle -N fzf-cmd
bindkey '^Xc' fzf-cmd
zle -N fzf-bookmark
bindkey '^Xb' fzf-bookmark

#-----------------------------------
# Others
#-----------------------------------
# nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
mkdir -p $HOME/.nodebrew/src

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
    --reverse --border --height 50%
  "
}
_gen_fzf_default_opts

# ignore case in completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# enable completion in the middle of word
setopt complete_in_word

# enable completion in command option
setopt magic_equal_subst

# no beep
setopt NOBEEP

# read local rc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi

# swiftenv
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

# pyenv
PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PYENV_ROOT
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

#-----------------------------------
# tmux auto start
#-----------------------------------
# http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
function tmux_automatically_attach_session()
{
  if is_screen_or_tmux_running; then
    ! is_exists 'tmux' && return 1

    if is_tmux_runnning; then
      printf "\e[31;1m  _____ __  __ _   ___  __ \e[m\n"
      printf "\e[31;1m |_   _|  \/  | | | \ \/ / \e[m\n"
      printf "\e[31;1m   | | | |\/| | | | |\  /  \e[m\n"
      printf "\e[31;1m   | | | |  | | |_| |/  \  \e[m\n"
      printf "\e[31;1m   |_| |_|  |_|\___//_/\_\ \e[m\n"
    elif is_screen_running; then
      echo "This is on screen."
    fi
  else
    if shell_has_started_interactively && ! is_ssh_running; then
      if ! is_exists 'tmux'; then
        echo 'Error: tmux command not found' 2>&1
        return 1
      fi

      if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '\[\d*x\d*\]'; then
        # detached session exists
        tmux list-sessions
        echo -n "Tmux: attach? (y/N/num) "
        read
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
          tmux attach-session
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
          tmux attach -t "$REPLY"
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        fi
      fi

      echo -n "Tmux: create new session? (y/N) "
      read
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        if is_osx && is_exists 'reattach-to-user-namespace'; then
          # on OS X force tmux's default command
          # to spawn a shell in the user's namespace
          tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
          tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
        else
          tmux new-session && echo "tmux created new session"
        fi
      fi
    fi
  fi
}
tmux_automatically_attach_session
