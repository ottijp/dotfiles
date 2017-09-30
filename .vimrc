" change current directory to file directory automatically
" set autochdir

" backup/swap/undo directories
set backupdir=$HOME/vimbackup
set directory=$HOME/vimbackup
set undodir=$HOME/vimbackup


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
augroup aug_tab_indent
  autocmd!
  autocmd Filetype markdown call ChangeTabWidth(4)
augroup END

"""" }
""""""""""""""""""""""""""""""

" filetypes
augroup aug_filetypes
  autocmd!
  autocmd BufRead,BufWrite *.jade setfiletype pug
  autocmd BufRead,BufWrite *.pug setfiletype pug
  autocmd BufRead *.vue setfiletype html
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
set statusline=%f\ %m\%r%h%w%q%=%l/%L(%3.3p%%)\ %3.c\ [0x%04.4B]\ %y\ [%{&fileencoding}]

" search
" highlight matched
set hlsearch
" enable incremental search
set incsearch


" save shortcut
nnoremap gw :w<CR>

" disable search highlight
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap <C-g><C-g> :nohlsearch<CR>
" case insensitive
set ignorecase

" cursor movement in insert mode
" inoremap <C-n> <Down>
" inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" editing in insert mode
inoremap <silent> <C-h> <C-g>u<C-h>
inoremap <silent> <C-d> <Del>

" Enter to feed line (S-CR needs some trick)
function! NewLineWithEnter()
    if &modifiable
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

" space to add space
nnoremap <Space> i<Space><Esc>l

" escape keymaps
inoremap <silent> <C-g> <ESC>
nnoremap <silent> <C-g> <ESC>
cnoremap <silent> <C-g> <ESC>

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

" color scheme
syntax enable
function! UpdateColorScheme()
  if &readonly && &buftype ==# "" && @% !~ "^fugitive:\/\/" && expand("%:p") !~ "\.git\/index$"
    set background=light
    colorscheme morning
  else
    set background=dark
    colorscheme solarized
  endif
endfunction
augroup my_colorscheme
  autocmd!
  autocmd BufReadPost,BufEnter * call UpdateColorScheme()
augroup END


filetype plugin indent off

if has('vim_starting')
        set runtimepath+=$HOME/.vim/bundle/neobundle.vim
        call neobundle#begin(expand('~/.vim/bundle/'))
        NeoBundleFetch 'Shougo/neobundle.vim'
        NeoBundle "Shougo/unite.vim"
        NeoBundle "Shougo/neomru.vim"
        NeoBundleLazy 'scrooloose/nerdtree', {
              \   'commands' : 'NERDTree'
              \}
        NeoBundle "tomtom/tcomment_vim"
        "NeoBundle "h1mesuke/vim-alignta"
        NeoBundleLazy 'plasticboy/vim-markdown', {
              \   'autoload' : { 'filetypes' : ['markdown'] }
              \}
        NeoBundleLazy 'kannokanno/previm', {
              \   'autoload' : { 'filetypes' : ['markdown'] }
              \}
        NeoBundle 'tyru/open-browser.vim'
        NeoBundle 'xolox/vim-session', { 'depends' : 'xolox/vim-misc' }
        NeoBundle 'kana/vim-submode'
        NeoBundle 'fatih/vim-go'
        NeoBundle "aklt/plantuml-syntax"
        NeoBundle 'thinca/vim-quickrun'
        NeoBundle 'myhere/vim-nodejs-complete'
        NeoBundle 'kchmck/vim-coffee-script'
        NeoBundle 'tpope/vim-fugitive'
        NeoBundle 'szw/vim-tags'
        NeoBundle 'othree/yajs.vim'
        NeoBundle 'cohama/lexima.vim'
        NeoBundle 'Shougo/neocomplete.vim'
        NeoBundle 'majutsushi/tagbar'
        NeoBundleLazy 'leafgarland/typescript-vim', {
              \   'autoload' : { 'filename_patterns' : '.*\.ts' }
              \}
        NeoBundleLazy 'Rykka/riv.vim', {
              \   'autoload' : { 'filetypes' : ['rst'] }
              \}
        NeoBundle 'Quramy/vim-js-pretty-template'
        NeoBundle 'Shougo/context_filetype.vim'
        NeoBundle 'osyo-manga/vim-precious'
        NeoBundle 'digitaltoad/vim-pug'
        NeoBundle 'tpope/vim-surround'
        NeoBundle 'junegunn/fzf'
        NeoBundle 'altercation/vim-colors-solarized'
        NeoBundle 'Shougo/vimfiler'
        NeoBundle 'mattn/benchvimrc-vim'
        NeoBundle 'junegunn/vim-easy-align'
        NeoBundle 'kana/vim-textobj-user'
        NeoBundle 'kana/vim-textobj-jabraces'
        NeoBundle 'osyo-manga/vim-textobj-multiblock'
        NeoBundle 'osyo-manga/vim-textobj-multitextobj'
        NeoBundle 'tpope/vim-commentary'
        NeoBundle 'kana/vim-textobj-line'
        NeoBundle 'deton/jasegment.vim'

        call neobundle#end()
endif

filetype plugin indent on



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
noremap <C-Z><C-Z> :Unite file_mru<CR>
" open with splitting window
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" open with vertical-splitting window
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" close Unite with ESCx2
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" set default action to vimfiler in bookmark
call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
"""" NERDTree {
nnoremap <silent><C-e> :NERDTreeToggle<CR>
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
" .md as markdown
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '$HOME/github.css'

""""""""""""""""""""""""""""""
" vim-session
""""""""""""""""""""""""""""""
" use .'vimsessions/' of current directory
let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
" if it exists
if isdirectory(s:local_session_directory)
  " './vimsessions/' as session directory
  let g:session_directory = s:local_session_directory
  " save on exit automatically
  let g:session_autosave = 'yes'
  " open 'default.vim' on startup with no arguments
  let g:session_autoload = 'yes'
  " save automatically every 1min
  let g:session_autosave_periodic = 1
else
  let g:session_autosave = 'no'
  let g:session_autoload = 'no'
endif
unlet s:local_session_directory

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
" nodejs-complete
""""""""""""""""""""""""""""""
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
let g:node_usejscomplete = 1
inoremap <Nul> <C-x><C-o>

""""""""""""""""""""""""""""""
" plantuml
""""""""""""""""""""""""""""""
let g:plantuml_executable_script="~/bin/plantuml"


" window operations
nnoremap s <Nop>
" split
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l
" cursor movement
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w
" window switching
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sr <C-w>r
nnoremap sq :<C-u>q<CR>
" window size changing
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap s= <C-w>=
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
" list tab
nnoremap sT :<C-u>Unite tab<CR>
" new tab
nnoremap st :<C-U>tabnew<CR>
" change tab
nnoremap <C-l> gt
nnoremap <C-h> gT



""""""""""""""""""""""""""""""
" tag operation
""""""""""""""""""""""""""""""
" jump to definition
nnoremap ] g<C-]>
nnoremap s] <C-w>]
" set tags path
set tags+=./tags,tags;$HOME

""""""""""""""""""""""""""""""
"""" vim-tags {
let g:vim_tags_auto_generate = 1
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" tagbar {
nnoremap <C-t> :TagbarToggle<CR>
let g:tagbar_autoshowtag = 1
let g:tagbar_width = 30
let g:tagbar_map_togglesort = 'S'
"""" }
""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""
"""" diff {
" show in vertical window
set diffopt+=vertical
"""" }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"""" vim-markdown {
" do not insert indent automatically
let g:vim_markdown_new_list_item_indent = 0
"""" }
""""""""""""""""""""""""""""""



"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> pumvisible() ? "\<C-y><BS>" : "\<BS>"
inoremap <expr><BS> pumvisible() ? "\<C-y><BS>" : "\<BS>"
" Close popup by <Space> with inserting space.
inoremap <expr><Space> pumvisible() ? "\<C-y><Space>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


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
" vue single component file
let g:context_filetype#filetypes.html =
      \ [
      \   {
      \    'start': '<template\%( [^>]*\)\? lang="\(pug\|jade\)"\%( [^>]*\)\?>',
      \    'end': '</template>', 'filetype': 'pug',
      \   },
      \   {
      \    'start': '<style\%( [^>]*\)\? lang="s[ac]ss"\%( [^>]*\)\?>',
      \    'end': '</style>', 'filetype': 'scss',
      \   },
      \   {
      \    'start': '<script\%( [^>]*\)\? type="text/javascript"\%( [^>]*\)\?>',
      \    'end': '</script>', 'filetype': 'javascript',
      \   },
      \   {
      \    'start': '<script\%( [^>]*\)\? type="text/coffeescript"\%( [^>]*\)\?>',
      \    'end': '</script>', 'filetype': 'coffee',
      \   },
      \   {
      \    'start': '<script\%( [^>]*\)\?>',
      \    'end': '</script>', 'filetype': 'javascript',
      \   },
      \   {
      \    'start': '<style\%( [^>]*\)\?>',
      \    'end': '</style>', 'filetype': 'css',
      \   },
      \   {
      \    'start': '<[^>]\+ style="',
      \    'end': '"', 'filetype': 'css',
      \   },
      \ ]
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
if neobundle#tap('vim-textobj-multiblock')
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
"""" lexima {
  " avoid complementation except end of line
  call lexima#add_rule({'char': '(', 'at': '\%#[^$]', 'leave': 1})
  call lexima#add_rule({'char': '{', 'at': '\%#[^$]', 'leave': 1})
  call lexima#add_rule({'char': '[', 'at': '\%#[^$]', 'leave': 1})
  call lexima#add_rule({'char': '"', 'at': '\%#[^$]', 'leave': 1})
  call lexima#add_rule({'char': "'", 'at': '\%#[^$]', 'leave': 1})
  call lexima#add_rule({'char': "`", 'at': '\%#[^$]', 'leave': 1})
"""" }
""""""""""""""""""""""""""""""

" read local setting
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
