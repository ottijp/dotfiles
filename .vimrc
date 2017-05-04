" 新しい行のインデントを現在行と同じにする
set autoindent
" 新しい行で高度な自動インデント
set smarttab

" ファイルのあるディレクトリをカレントディレクトリにする
set autochdir

" バックアップ、スワップファイルの変更
set backupdir=$HOME/vimbackup
set directory=$HOME/vimbackup
set undodir=$HOME/vimbackup

" タブの代わりに空白文字を指定
set expandtab

" タブ幅
set tabstop=2
set shiftwidth=2

" filetypes
augroup my_filetypes
  autocmd!
  autocmd BufRead,BufWrite *.jade setfiletype pug
  autocmd BufRead,BufWrite *.pug setfiletype pug
  autocmd BufRead *.vue setfiletype html
  " Markdown
  autocmd BufNewFile,BufRead *.md setlocal tabstop=4 shiftwidth=4
augroup END

" 勝手に改行しない
set tw=0

" UI
" 行番号
set number
" ルーラー
set ruler
" 対応する括弧の強調表示
set showmatch

" 検索
" ハイライト
set hlsearch
" インクリメンタルサーチ
set incsearch
" disable search highlight
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap <C-g><C-g> :nohlsearch<CR>
" 大文字小文字無視
set ignorecase

" 挿入モードでのカーソル移動
" inoremap <C-n> <Down>
" inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" 挿入モードでの編集
inoremap <silent> <C-h> <C-g>u<C-h>
inoremap <silent> <C-d> <Del>
inoremap <silent> <C-k> <Esc>lc$
inoremap <silent> <C-a> <C-o>0
inoremap <silent> <C-e> <C-o>$

" 通常モードEnterで空行挿入(S-CRは使うのにトリックが要る）
function! NewLineWithEnter()
    if &modifiable
        execute "normal! o\<ESC>"
    else
        execute "normal! \<CR>"
    endif
endfunction
nnoremap <CR> :call NewLineWithEnter()<CR>

" space to add space
nnoremap <Space> i<Space><Esc>


" 引用符、括弧の自動補完
"inoremap { {}<Left>
"inoremap [ []<Left>
"inoremap ( ()<Left>
"inoremap " ""<Left>
"inoremap ' ''<Left>
"inoremap <> <><Left> 

" キャンセル
inoremap <silent> <C-g> <ESC>
nnoremap <silent> <C-g> <ESC>
cnoremap <silent> <C-g> <ESC>

" Make系
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





" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
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
function UpdateColorScheme()
  if &readonly && &buftype ==# ""
    colorscheme morning
  else
    colorscheme hybrid
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

        NeoBundle "sudar/vim-arduino-syntax"
        NeoBundle "Shougo/unite.vim"
        NeoBundle "Shougo/neomru.vim"
        NeoBundle "scrooloose/nerdtree"
        NeoBundle "tomtom/tcomment_vim"
        "NeoBundle "h1mesuke/vim-alignta"
        NeoBundle 'plasticboy/vim-markdown'
        NeoBundle 'kannokanno/previm'
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
        NeoBundle 'leafgarland/typescript-vim'
        NeoBundle 'Rykka/riv.vim'
        NeoBundle 'Quramy/vim-js-pretty-template'
        NeoBundle 'Shougo/context_filetype.vim'
        NeoBundle 'osyo-manga/vim-precious'
        NeoBundle 'digitaltoad/vim-pug'
        NeoBundle 'tpope/vim-surround'
        NeoBundle 'junegunn/fzf'

        call neobundle#end()
endif

filetype plugin indent on



" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unite.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
"let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-X> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
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
" PreVimの設定
""""""""""""""""""""""""""""""
" .mdをマークダウン拡張子にする
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '$HOME/github.css'

""""""""""""""""""""""""""""""
" vim-sessionの設定
""""""""""""""""""""""""""""""
" 現在のディレクトリ直下の .vimsessions/ を取得 
let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
" 存在すれば
if isdirectory(s:local_session_directory)
  " session保存ディレクトリをそのディレクトリの設定
  let g:session_directory = s:local_session_directory
  " vimを辞める時に自動保存
  let g:session_autosave = 'yes'
  " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
  let g:session_autoload = 'yes'
  " 1分間に1回自動保存
  let g:session_autosave_periodic = 1
else
  let g:session_autosave = 'no'
  let g:session_autoload = 'no'
endif
unlet s:local_session_directory

""""""""""""""""""""""""""""""
" quickrunの設定
""""""""""""""""""""""""""""""
" 下部に結果を表示
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright"
\   },
\}
let g:quickrun_config.coffeejs = {'command': 'coffee', 'cmdopt': '-pb'}

""""""""""""""""""""""""""""""
" nodejs-completeの設定
""""""""""""""""""""""""""""""
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
let g:node_usejscomplete = 1
inoremap <Nul> <C-x><C-o>

""""""""""""""""""""""""""""""
" plantumlの設定
""""""""""""""""""""""""""""""
let g:plantuml_executable_script="~/bin/plantuml"


" ウィンドウ操作
nnoremap s <Nop>
" 分割
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l
" カーソル移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w
" ウィンドウ移動
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sr <C-w>r
nnoremap sq :<C-u>q<CR>
" ウィンドウサイズ変更
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

" read local setting
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
