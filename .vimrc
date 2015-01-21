" 新しい行のインデントを現在行と同じにする
set autoindent
" 新しい行で高度な自動インデント
set smarttab

" バックアップ、スワップファイルの変更
set backupdir=$HOME/vimbackup
set directory=$HOME/vimbackup

" Vim互換をOFF
set nocompatible

" タブの代わりに空白文字を指定
set expandtab

" タブ幅
set tabstop=4
set shiftwidth=4

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
nnoremap <C-g><C-g> :nohlsearch<CR>
" 大文字小文字無視
set ignorecase




" 挿入モードでのカーソル移動
inoremap <C-n> <Down>
inoremap <C-p> <Up>
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


colorscheme hybrid


filetype plugin indent off

if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim
        call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle "sudar/vim-arduino-syntax"

filetype plugin indent on

