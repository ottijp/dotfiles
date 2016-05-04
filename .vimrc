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

" Vim互換をOFF
set nocompatible

" タブの代わりに空白文字を指定
set expandtab

" タブ幅
set tabstop=4
set shiftwidth=4

" js,coffee,jadeは2
autocmd filetype coffee,javascript,jade setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

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
"ハイライトをC-G連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>
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
nnoremap <CR> o<ESC>


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

colorscheme hybrid


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
noremap <C-Z> :Unite file_mru<CR>
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
" NERDTreeの設定
""""""""""""""""""""""""""""""
nnoremap <silent><C-e> :NERDTreeToggle<CR>


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



" ウィンドウ操作
nnoremap s <Nop>
" 分割
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
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
" タブ移動
nnoremap sT :<C-u>Unite tab<CR>
nnoremap st :<C-U>tabnew<CR>
nnoremap sn gt
nnoremap sp gT


