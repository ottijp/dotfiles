function command_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_running() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_running; }
function shell_has_started_interactively() { [ ! -z "$PROMPT" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONNECTION" ]; }

function chpwd () { ls -GF }
function mkdircd () { mkdir -p "$@" && builtin cd "$@" }
