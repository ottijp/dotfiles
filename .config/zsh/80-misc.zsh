for file in $(dirname $0)/misc/*.zsh; do
  [ -r "$file" ] && source "$file"
done
