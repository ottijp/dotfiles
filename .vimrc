" change current directory to file directory automatically
" set autochdir

" backup/swap/undo directories
set backupdir=$HOME/vimbackup
set directory=$HOME/vimbackup
set undodir=$HOME/vimbackup

" space key for <Leader>
let mapleader = "\<Space>"

""""""""""""""""""""""""""""""
"""" tab and indent {
" space instead of tab
set expandtab

" default tab width
set tabstop=2
set shiftwidth=2
set softtabstop=2

" change tab width
function! ChangeTabWidth(w)
  let &l:tabstop = a:w
  let &l:shiftwidth = a:w
  let &l:softtabstop = a:w
endfunction

" indent on new line
set autoindent

" block indentation
set smarttab

" extension customize
augroup aug_markdown
  autocmd!
  " .md as markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd Filetype markdown call ChangeTabWidth(4)
augroup END

"""" }
""""""""""""""""""""""""""""""

" filetypes
augroup aug_filetypes
  autocmd!
  autocmd BufEnter,VimEnter * if expand("%") == "" && &filetype == "" | setlocal ft=markdown | endif
  autocmd BufRead,BufNewFile *.jade,*.pug setfiletype pug
  autocmd BufRead,BufNewFile *.vue setfiletype vue
  autocmd BufRead,BufNewFile *.sol setfiletype solidity
  autocmd BufRead,BufNewFile *.swift setfiletype swift
  autocmd BufRead,BufNewFile *.uml,*.pu,*plantuml setfiletype plantuml
  autocmd BufWinEnter * :PreciousReset | :PreciousSwitch
augroup END

" prevent auto line feeding
set tw=0

" show line-break sign
set showbreak=↪\ 

" UI
" show number of line
set number
" show ruler
set ruler
" highlight corresponding parenthesis
set showmatch
" statusline
set noshowmode
set laststatus=2


" search
" highlight matched
set hlsearch
" enable incremental search
set incsearch
" use very magic as default
nnoremap / /\v
cnoremap %s/ %s/\v

" save buffer
nnoremap gw :w<CR>
" close buffer
nnoremap gq :q<CR>

" disable search highlight
nnoremap <Leader>h :set nohlsearch!<CR>
" short cut for pasteboard
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P
" case insensitive
set ignorecase
" no infer case on completion
set noinfercase
" change split position
set splitbelow
set splitright

" cursor movement in insert mode
" inoremap <C-n> <Down>
" inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" editing in insert mode
inoremap <silent> <C-d> <Del>

" Enter to feed line (S-CR needs some trick)
function! NewLineWithEnter()
    if &modifiable && &buftype != 'quickfix'
        execute "normal! o\<ESC>"
    else
        execute "normal! \<CR>"
    endif
endfunction
nnoremap <CR> :call NewLineWithEnter()<CR>
augroup cmdwindow
  autocmd!
  autocmd CmdwinLeave * nnoremap <buffer> <CR> :call NewLineWithEnter()<CR>
  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

" add space
nnoremap g<Space> i<Space><Esc>l

" Make
nnoremap <silent> <F5> :w <CR> :make <CR>
nnoremap <silent> <F6> :w <CR> :make run <CR>

" toggle openfixwindow
let s:quickfixwindow = "close"
function! OpenCloseQuickfix()
    if "open" ==? s:quickfixwindow
        let s:quickfixwindow = "close"
        :cclose
    else
        let s:quickfixwindow = "open"
        :copen
    endif
endfunction
nnoremap <silent> <F7> :call OpenCloseQuickfix() <CR>
inoremap <silent> <F7> :call OpenCloseQuickfix() <CR>

" Quickfix list movement
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>


" smart concatenation of comment lines
set formatoptions+=j

" Git related
augroup git
  autocmd!
  autocmd VimEnter COMMIT_EDITMSG setlocal spell
  autocmd VimEnter COMMIT_EDITMSG setlocal spelllang=en,cjk
augroup END

" command history
set history=1000

" command history with filter
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" working directory completion
cnoremap <expr> %% getcmdtype() == ":" ? expand('%:h') : "%%"

" digraphs for vowel of hiragana
dig aa 12354 "あ
dig ii 12356 "い
dig uu 12358 "う
dig ee 12360 "え
dig oo 12362 "お
dig AA 12353 "ぁ
dig II 12355 "ぃ
dig UU 12357 "ぅ
dig EE 12359 "ぇ
dig OO 12361 "ぉ

" add match pairs
set matchpairs+=「:」,【:】,（:）,＜:＞,｛:｝

" disable fold by default
set nofoldenable


" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" highlight full-width space
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

filetype plugin indent off

""""""""""""""""""""""""""""""
" plugin
""""""""""""""""""""""""""""""
if &compatible
  set nocompatible
endif
" dein dir path
let s:dein_dir = expand('~/.vim/bundles')
" dein.vim path
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" if dein.vim not found, install it
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add(s:dein_repo_dir)
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/context_filetype.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('tyru/open-browser.vim')
  call dein#add('godlygeek/tabular')
  call dein#add('cohama/lexima.vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('junegunn/fzf', { 'build': './install --all' })
  call dein#add('junegunn/fzf.vim')
  call dein#add('rhysd/clever-f.vim')
  call dein#add('kana/vim-submode')
  call dein#add('kana/vim-textobj-line')
  call dein#add('kana/vim-textobj-user')
  call dein#add('kana/vim-textobj-jabraces')
  call dein#add('osyo-manga/vim-textobj-multiblock')
  call dein#add('osyo-manga/vim-textobj-multitextobj')
  call dein#add('osyo-manga/vim-precious')
  call dein#add('itchyny/lightline.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('deton/jasegment.vim')
  call dein#add('neomake/neomake')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-speeddating')
  " call dein#add('mattn/benchvimrc-vim')

  call dein#add('plasticboy/vim-markdown', { 'lazy': 1, 'on_ft': 'markdown' })
  call dein#add('fatih/vim-go', { 'lazy': 1, 'on_ft': 'go' })
  call dein#add('Rykka/riv.vim', { 'lazy': 1, 'on_ft': 'rst' })
  call dein#add('leafgarland/typescript-vim', { 'lazy': 1, 'on_ft': 'typescript' })
  call dein#add('othree/yajs.vim', { 'lazy': 1, 'on_ft': ['typescript', 'javascript'] })
  call dein#add('othree/es.next.syntax.vim', { 'lazy': 1, 'on_ft': ['typescript', 'javascript'] })
  call dein#add('Quramy/vim-js-pretty-template', { 'lazy': 1, 'on_ft': ['typescript', 'javascript'] })
  call dein#add('kannokanno/previm', { 'lazy': 1, 'on_ft': 'markdown' })
  call dein#add('aklt/plantuml-syntax', { 'lazy': 1, 'on_ft': 'plantuml' })
  call dein#add('digitaltoad/vim-pug', { 'lazy': 1, 'on_ft': 'pug' })
  call dein#add('keith/swift.vim', { 'lazy': 1, 'on_ft': 'swift' })
  call dein#add('tomlion/vim-solidity', { 'lazy': 1, 'on_ft': 'solidity' })

  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
  call dein#save_state()
  call map(dein#check_clean(), "delete(v:val, 'rf')")
endif
""""""""""""""""""""""""""""""

filetype plugin indent on
syntax enable

" color scheme
syntax enable
set background=dark
colorscheme solarized
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filepath', 'modified'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \   'filepath': '%f'
      \ },
      \ }

" light color for MatchParen background
highlight MatchParen ctermbg=0

" prevent editing readonly file
autocmd BufRead * let &modifiable = !&readonly

" increment/decrement indent repeatably
call submode#enter_with('indent', 'i', '', '<C-a>>', '<C-t>')
call submode#enter_with('indent', 'i', '', '<C-a><', '<C-d>')
call submode#map('indent', 'i', '', '>', '<C-t>')
call submode#map('indent', 'i', '', '<', '<C-d>')

" convert punctuation marks
nnoremap <Leader>cp :%s/、/，/ge<CR>:%s/。/．/ge<CR>
vnoremap <Leader>cp :s/、/，/ge<CR>gv:s/。/．/ge<CR>

" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unite.vim
""""""""""""""""""""""""""""""
" start with insert mode
"let g:unite_enable_start_insert=1
" show buffer
noremap <C-P> :Unite buffer<CR>
" show files of current file's directory
noremap <C-N> :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" show most recently used
noremap <Leader>m :Unite file_mru<CR>
" open with splitting window
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" open with vertical-splitting window
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" set default action to vimfiler in bookmark
call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
"""" NERDTree {
nnoremap <silent><Leader>f :NERDTreeToggle<CR>
" quit NERDTree on open
let g:NERDTreeQuitOnOpen=1
" ignore system files
let g:NERDTreeIgnore=['\.DS_Store']
" show hidden files on startup
let g:NERDTreeShowHidden=1
" show bookmarks on startup
let g:NERDTreeShowBookmarks=1
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"""" }
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" PreVim
""""""""""""""""""""""""""""""
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '$HOME/templates/previm/github.css'

""""""""""""""""""""""""""""""
" quickrun
""""""""""""""""""""""""""""""
" show result at bottom
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright"
\   },
\}
let g:quickrun_config.coffeejs = {'command': 'coffee', 'cmdopt': '-pb'}

""""""""""""""""""""""""""""""
" plantuml
""""""""""""""""""""""""""""""
let g:plantuml_executable_script="~/bin/plantuml"


""""""""""""""""""""""""""""""
" tab and window operations
""""""""""""""""""""""""""""""
" new tab
nnoremap <C-w>t :<C-U>tabnew<CR>
nnoremap <C-w><C-t> :<C-U>tabnew<CR>
" move tab
nnoremap <C-l> gt
nnoremap <C-h> gT
" maximize/minimize window
nnoremap <C-w>o <C-w>_<C-w>|
nnoremap <C-w><C-o> <C-w>_<C-w>|
nnoremap <C-w>O <C-w>_<C-w>=
" change window size repeatably
call submode#enter_with('bufmove', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('bufmove', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')


""""""""""""""""""""""""""""""
"""" diff {
" show diff vertically
if &diff
  set diffopt-=internal
endif
set diffopt+=vertical
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" vim-markdown {
" do not insert indent automatically
let g:vim_markdown_new_list_item_indent = 0
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" lexima {
  call lexima#init()
  " japanese surrounds
  call lexima#add_rule({'char': '「', 'input_after': '」', 'at': '\%#$'})
  call lexima#add_rule({'char': '」', 'at': '\%#」', 'leave': 1})
  call lexima#add_rule({'char': '【', 'input_after': '】', 'at': '\%#$'})
  call lexima#add_rule({'char': '】', 'at': '\%#】', 'leave': 1})
  call lexima#add_rule({'char': '（', 'input_after': '）', 'at': '\%#$'})
  call lexima#add_rule({'char': '）', 'at': '\%#）', 'leave': 1})
  call lexima#add_rule({'char': '＜', 'input_after': '＞', 'at': '\%#$'})
  call lexima#add_rule({'char': '＞', 'at': '\%#＞', 'leave': 1})
  call lexima#add_rule({'char': '｛', 'input_after': '｝', 'at': '\%#$'})
  call lexima#add_rule({'char': '｝', 'at': '\%#｝', 'leave': 1})
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" vim-js-pretty-template {
autocmd FileType typescript JsPreTmpl markdown
autocmd FileType typescript syn clear foldBraces
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" context_filetype {
if !exists('g:context_filetype#filetypes')
    let g:context_filetype#filetypes = {}
endif
" for vue single file component
let g:context_filetype#filetypes.vue =
      \ [
      \   {
      \    'start': '<template\%( [^>]*\)\? lang="\(pug\|jade\)"\%( [^>]*\)\?>',
      \    'end': '</template>', 'filetype': 'pug',
      \   },
      \   {
      \    'start': '<template\%( [^>]*\)\?>',
      \    'end': '</template>', 'filetype': 'html',
      \   },
      \   {
      \    'start':
      \     '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
      \    'end': '</script>', 'filetype': 'typescript',
      \   },
      \   {
      \    'start': '<script\%( [^>]*\)\?>',
      \    'end': '</script>', 'filetype': 'javascript',
      \   },
      \   {
      \    'start': '<style\%( [^>]*\)\? lang="s[ac]ss"\%( [^>]*\)\?>',
      \    'end': '</style>', 'filetype': 'scss',
      \   },
      \   {
      \    'start': '<style\%( [^>]*\)\?>',
      \    'end': '</style>', 'filetype': 'css',
      \   }
      \ ]
" disable defaults
let g:context_filetype#filetypes.help = []
let g:context_filetype#filetypes.markdown = []
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" vim-easy-align {
xmap ga <Plug>(EasyAlign)
let g:easy_align_delimiters = {
\  ':': { 'pattern': ':', 'left_margin': 0, 'right_margin': 1, 'stick_to_left': 0 }
\ }
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" vim-textobj-multiblock {
if dein#tap('vim-textobj-multiblock')
    let g:textobj_multitextobj_textobjects_i = [
    \ "\<Plug>(textobj-multiblock-i)",
    \ "\<Plug>(textobj-jabraces-parens-i)",
    \ "\<Plug>(textobj-jabraces-braces-i)",
    \ "\<Plug>(textobj-jabraces-brackets-i)",
    \ "\<Plug>(textobj-jabraces-angles-i)",
    \ "\<Plug>(textobj-jabraces-double-angles-i)",
    \ "\<Plug>(textobj-jabraces-kakko-i)",
    \ "\<Plug>(textobj-jabraces-double-kakko-i)",
    \ "\<Plug>(textobj-jabraces-yama-kakko-i)",
    \ "\<Plug>(textobj-jabraces-double-yama-kakko-i)",
    \ "\<Plug>(textobj-jabraces-kikkou-kakko-i)",
    \ "\<Plug>(textobj-jabraces-sumi-kakko-i)",
    \]
    let g:textobj_multitextobj_textobjects_a = [
    \ "\<Plug>(textobj-multiblock-a)",
    \ "\<Plug>(textobj-jabraces-parens-a)",
    \ "\<Plug>(textobj-jabraces-braces-a)",
    \ "\<Plug>(textobj-jabraces-brackets-a)",
    \ "\<Plug>(textobj-jabraces-angles-a)",
    \ "\<Plug>(textobj-jabraces-double-angles-a)",
    \ "\<Plug>(textobj-jabraces-kakko-a)",
    \ "\<Plug>(textobj-jabraces-double-kakko-a)",
    \ "\<Plug>(textobj-jabraces-yama-kakko-a)",
    \ "\<Plug>(textobj-jabraces-double-yama-kakko-a)",
    \ "\<Plug>(textobj-jabraces-kikkou-kakko-a)",
    \ "\<Plug>(textobj-jabraces-sumi-kakko-a)",
    \]
    omap ab <Plug>(textobj-multitextobj-a)
    omap ib <Plug>(textobj-multitextobj-i)
    vmap ab <Plug>(textobj-multitextobj-a)
    vmap ib <Plug>(textobj-multitextobj-i)
endif
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" vim-commentary {
augroup vim_commentary
  autocmd!
  autocmd FileType text setlocal commentstring=//\ %s
augroup END
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" vim-surround {
  " add japanese surrounds
  let g:surround_{char2nr("「")} = "「 \r 」"
  let g:surround_{char2nr("」")} = "「\r」"
  let g:surround_{char2nr("【")} = "【 \r 】"
  let g:surround_{char2nr("】")} = "【\r】"
  let g:surround_{char2nr("（")} = "（ \r ）"
  let g:surround_{char2nr("）")} = "（\r）"
  let g:surround_{char2nr("＜")} = "＜ \r ＞"
  let g:surround_{char2nr("＞")} = "＜\r＞"
  let g:surround_{char2nr("｛")} = "｛ \r ｝"
  let g:surround_{char2nr("｝")} = "｛\r｝"
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" neomake {
" let g:neomake_verbose = 3
" let g:neomake_logfile = '/tmp/neomake.log'
let g:neomake_error_sign = {'text': '>>', 'texthl': 'Error'}
let g:neomake_warning_sign = {'text': '>>',  'texthl': 'Todo'}
call neomake#configure#automake('nrw', 750)
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" tern {
let g:tern_show_signature_in_pum = 1
let g:tern_show_argument_hints = 'on_move'
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" clever-f {
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" fzf {
function! s:FzfBookmark()
  let l:BS = "\u08" " <C-h>
  let l:cmdtype = getcmdtype()
  let l:args = {
  \   'source': 'cat $HOME/bookmarks',
  \   'sink': { lines -> lines }
  \ } " sink does nothing
  if l:cmdtype == ':'
    let l:list = fzf#run(fzf#wrap(l:args))
    if len(list)
      return escape(substitute(list[0], '^.\{-,},', '', ''), ' ')
    else
      return 'a' . l:BS " workaround for redraw problem
    endif
  endif
endfunction

function! s:FzfFile()
  let l:BS = "\u08" " <C-h>
  let l:cmdtype = getcmdtype()
  let l:cmdline = getcmdline()
  let l:dir = substitute(l:cmdline, '^[^\\]\+ \(.\{-1,}\)/\?$', '\1', '')
  let l:args = {
  \   'source': 'find ' . l:dir . ' -follow',
  \   'sink': { lines -> lines }
  \ } " sink does nothing
  if l:cmdtype == ':'
    let l:list = fzf#run(fzf#wrap(l:args))
    if len(list)
      return "\<C-u>" . substitute(l:cmdline, '^\([^\\]\+ \)\(.\{-1,}\)$', '\1' . escape(list[0], ' '), '')
    else
      return 'a' . l:BS " workaround for redraw problem
    endif
  endif
  return ''
endfunction

cnoremap <expr> <C-x>b <SID>FzfBookmark()
cnoremap <expr> <C-x>f <SID>FzfFile()
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" MarkuPrev {
function! OpenWithMarkuPrev()
  echo system('open /Applications/MarkuPrev.app' . ' -n --args ' . shellescape(expand('%:p')))
endfunction
command! MarkuPrev call OpenWithMarkuPrev()
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" gitgutter {
highlight! link SignColumn LineNr
"""" }
""""""""""""""""""""""""""""""

" read local setting
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

