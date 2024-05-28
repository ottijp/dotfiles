" default to markdown
au BufEnter,WinEnter *	if empty(&ft) | set ft=markdown | endif
