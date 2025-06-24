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
  selected=`(cat ~/bookmarks | grep -vE "^#" | grep -vE "^$" 2>/dev/null) | fzf`
  if [ -n "$selected" ]; then
    LBUFFER=${LBUFFER}"`awk 'BEGIN{FS=","}{print $2}' <<<"$selected" | sed 's/ /\\\\ /g'` "
  fi
  zle reset-prompt
}

# setup
if command_exists 'fzf'; then
  source <(fzf --zsh)
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
      --reverse --border
      --bind 'up:preview-up'
      --bind 'down:preview-down'
      --bind 'ctrl-d:half-page-down'
      --bind 'ctrl-u:half-page-up'
      --bind 'ctrl-f:page-down'
      --bind 'ctrl-b:page-up'
      --bind 'ctrl-u:page-up'
    "
  }
  _gen_fzf_default_opts
fi

