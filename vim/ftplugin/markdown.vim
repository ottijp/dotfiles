" Create link with selected text and copied URL
function! s:MarkdownCreateLink()
  if &filetype != 'markdown'
    return
  endif
  let url = getreg('*')
  let keys = "gvs[\<C-r>\"](".url.")\<ESC>"
  call feedkeys(keys, 'n')
endfunction


" Create link with selected text and copied URL
vnoremap <buffer> <silent> <Leader>l :call <SID>MarkdownCreateLink()<CR>
