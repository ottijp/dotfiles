# XDG paths
# delete after migration to zshenv
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

for file in $XDG_CONFIG_HOME/zsh/*.zsh; do
  [ -r "$file" ] && source "$file"
done

# undef console output stop (enable incremental search)
stty stop undef

# avoid duplicated PATHs
typeset -U path PATH

fpath=($XDG_CONFIG_HOME/zsh/completion /usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit

# Display a warning if tmux is not running in an interactive shell and no screen or tmux session is active
if shell_has_started_interactively \
  && ! is_ssh_running \
  && command_exists 'tmux' \
  && ! is_screen_or_tmux_running \
  ; then
  printf "\e[31;1mtmux is not running\e[m\n"
fi
