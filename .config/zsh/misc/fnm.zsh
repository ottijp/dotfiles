if which fnm >/dev/null 2>&1; then
  eval "$(fnm completions --shell zsh)"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
