# locale
export LC_ALL=en_US.UTF-8

# prompt
setopt PROMPT_SUBST

# cd completion
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# ignore case in completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# enable completion in the middle of word
setopt complete_in_word

# enable completion in command option
setopt magic_equal_subst

# no beep
setopt NOBEEP

# prompt
export PROMPT=$'%{\e[36m%}%n@%m:%{\e[35m%}%c%{\e[0;34m%}$(__git_ps1 " (%s)")%{\e[36m%} \$%{\e[0m%} '

# command histories
mkdir -p ${XDG_STATE_HOME:-$HOME/.local/state}/zsh
export HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/.zhistory
touch ~/.zhistory
export HISTSIZE=10000
export SAVEHIST=9000000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt share_history
setopt hist_reduce_blanks

# report time of long task
export REPORTTIME=10

# cd stack size
export DIRSTACKSIZE=100

# local bin path
export PATH=$PATH:~/bin:~/bin.local

# editor for osx
MACVIM_PATH="/Applications/MacVim.app"
if is_osx and [ -f "$MACVIM_PATH" ]; then
  export EDITOR="$MACVIM_PATH/Contents/MacOS/Vim"
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

# WORDCHAR
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
mkdir -p $HOME/.nodebrew/src

# pyenv
PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PYENV_ROOT
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi

# swiftenv
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

source ~/.zsh/completion/git-prompt.sh

