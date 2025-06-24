# ls
if is_osx; then
  alias ls="ls -GF"
  alias la="ls -GFa"
  alias ll="ls -GFlh"
  alias lla="ls -GFalh"
else
  alias ls="ls -F"
  alias la="ls -Fa"
  alias ll="ls -Flh"
  alias lla="ls -Falh"
fi

# mkdir
alias mkdir='mkdir -p'

# tmux
alias tmux-changekey='tmux set-option -ag prefix C-b'
alias tmux-revertkey='tmux set-option -ag prefix C-t'
alias tmux-new-session-currentpath='tmux new-session -c "$PWD"'

# ctags
if command_exists 'brew' ; then
  alias ctags=`brew --prefix`/bin/ctags
fi

# git
alias gs="git status"
alias gf="git diff"
alias gfc="git diff --cached"

# tree
alias tree="tree -N -I node_modules -L 3"

# grep
alias grep="grep --color=auto"

# df
alias df="df -h"

# tar
alias tgz="tar czvf"
alias untgz="tar xzvf"

# GitHub Copilot
alias explain='ghce'
alias suggest='ghcs'

# vim
MACVIM_PATH="/Applications/MacVim.app"
if is_osx and [ -f "$MACVIM_PATH" ]; then
  alias vim='env LANG=ja_JP.UTF-8 '"$MACVIM_PATH"'/Contents/MacOS/Vim -u ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc "$@"'
  alias vi=vim
else
  alias vim='vim -u ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc'
fi
