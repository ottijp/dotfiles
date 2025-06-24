for file in $(dirname $0)/misc/*.zsh $(dirname $0)/misc/*.sh; do
  [ -r "$file" ] && source "$file"
done
