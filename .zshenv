# XDG paths
# change to "export" after migration to zshenv
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# zsh config path
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# locale
export LC_ALL=en_US.UTF-8

# AWS
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"

# Azure
export AZURE_CONFIG_DIR="$XDG_CONFIG_HOME/azure"

# node
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# ruby
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_PATH="$GEM_HOME"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem

# .NET
export DOTNET_ROOT="$XDG_DATA_HOME/dotnet"

# rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
if [[ -d "$CARGO_HOME" ]] then
  . "$CARGO_HOME/env"
fi
