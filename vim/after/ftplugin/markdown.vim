" Create link with selected text and copied URL
function! s:MarkdownCreateLink()
  if &filetype != 'markdown'
    return
  endif
  let url = getreg('*')
  let keys = "gvs[\<C-r>\"](".url.")\<ESC>"
  call feedkeys(keys, 'n')
endfunction

" insert `*` before line
function! s:MarkdownAddListPrefix()
  if mode() ==# 'v' || mode() ==# 'V' || mode() ==# "\<C-v>"
    " replace all selection if it's in visual mode
    execute '''<,''>s/\( \+\)\?/\1* /'
  else
    " repalce cursor line if it's in normal mode
    execute 's/\( \+\)\?/\1* /'
  endif
endfunction

" insert `[ ] ` before line
function! s:MarkdownAddCheckBox()
  if mode() ==# 'v' || mode() ==# 'V' || mode() ==# "\<C-v>"
    " replace all selection if it's in visual mode
    execute '''<,''>s/\( \+\)\?\(* \)\?/\1\2[ ] /'
  else
    " repalce cursor line if it's in normal mode
    execute 's/\( \+\)\?\(* \)\?/\1\2[ ] /'
  endif
endfunction

" Create link with selected text and copied URL
vnoremap <buffer> <silent> <Leader>l :call <SID>MarkdownCreateLink()<CR>

" insert `*` before line
nnoremap <buffer> <silent> <Leader>* :call <SID>MarkdownAddListPrefix()<CR>
vnoremap <buffer> <silent> <Leader>* :call <SID>MarkdownAddListPrefix()<CR>

" insert `[ ] ` before line
nnoremap <buffer> <silent> <Leader>[ :call <SID>MarkdownAddCheckBox()<CR>
vnoremap <buffer> <silent> <Leader>[ :call <SID>MarkdownAddCheckBox()<CR>

" tpope/vim-surround
" sc to surround with ```
let b:surround_{char2nr('c')} = "```\n\r\n```"

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|unlet! b:surround_{char2nr('c')}"
else
  let b:undo_ftplugin = "unlet! b:surround_{char2nr('c')}"
endif
