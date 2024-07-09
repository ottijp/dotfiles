fpath=(~/.zsh/completion /usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit
if [ -f /opt/homebrew/bin/brew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi
