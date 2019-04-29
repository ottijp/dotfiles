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
  autocmd BufNew,VimEnter * if &filetype == "" | setlocal ft=markdown | endif
  autocmd BufRead,BufNewFile *.jade,*.pug setfiletype pug
  autocmd BufRead,BufNewFile *.vue setfiletype vue
  autocmd BufRead,BufNewFile *.sol setfiletype solidity
  autocmd BufRead,BufNewFile *.swift setfiletype swift
  autocmd BufWinEnter * :PreciousReset | :PreciousSwitch
augroup END

" filetype: javascript
augroup ft_javascript
  autocmd!
  " get eslint path of current environment
  function! s:GetEslintExe()
    let l:eslintExe = GetNpmBin('eslint')
    if empty(l:eslintExe)
      return 'eslint'
    else
      return l:eslintExe
    endif
  endfunction

  " set exe of neomake eslint
  autocmd FileType javascript let g:neomake_javascript_myeslint_maker = {
        \ 'exe': s:GetEslintExe(),
        \ 'args': ['-f', 'compact', '--no-ignore'],
        \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
        \ '%W%f: line %l\, col %c\, Warning - %m'
        \ }
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


" search
" highlight matched
set hlsearch
" enable incremental search
set incsearch
" use very magic as default
nnoremap / /\v
cnoremap %s/ %s/\v

" save shortcut
nnoremap gw :w<CR>

" disable search highlight
nnoremap <silent><ESC><ESC> :set nohlsearch!<CR>
nnoremap <silent><C-g><C-g> :set nohlsearch!<CR>
" case insensitive
set ignorecase
" infer case on completion
set infercase

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

" space to add space
nnoremap <Space> i<Space><Esc>l

" escape keymaps
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

if has('vim_starting')
        set runtimepath+=$HOME/.vim/bundle/neobundle.vim

        " install neobundle if it's not installed
        if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
          echo "install NeoBundle..."
          :call system("git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
        endif

        call neobundle#begin(expand('~/.vim/bundle/'))
        NeoBundleFetch 'Shougo/neobundle.vim'
        NeoBundle "Shougo/unite.vim"
        NeoBundle "Shougo/neomru.vim"
        NeoBundleLazy 'scrooloose/nerdtree', {
              \   'commands' : 'NERDTree'
              \}
        NeoBundle "tomtom/tcomment_vim"
        "NeoBundle "h1mesuke/vim-alignta"
        NeoBundle 'godlygeek/tabular'
        NeoBundleLazy 'plasticboy/vim-markdown', {
              \   'autoload' : { 'filetypes' : ['markdown'] }
              \}
        NeoBundleLazy 'kannokanno/previm', {
              \   'autoload' : { 'filetypes' : ['markdown'] }
              \}
        NeoBundle 'tyru/open-browser.vim'
        NeoBundle 'xolox/vim-session', { 'depends' : 'xolox/vim-misc' }
        NeoBundle 'kana/vim-submode'
        NeoBundleLazy 'fatih/vim-go', {
              \   'autoload' : { 'filetypes' : ['go'] }
              \}
        NeoBundle "aklt/plantuml-syntax"
        NeoBundle 'thinca/vim-quickrun'
        NeoBundleLazy 'kchmck/vim-coffee-script', {
              \   'autoload' : { 'filetypes' : ['coffee'] }
              \}
        NeoBundle 'tpope/vim-fugitive'
        NeoBundleLazy 'othree/yajs.vim', {
              \   'autoload' : { 'filetypes' : ['javascript', 'typescript'] }
              \}
        NeoBundleLazy 'othree/es.next.syntax.vim', {
              \   'autoload' : { 'filetypes' : ['javascript', 'typescript'] }
              \}
        NeoBundleLazy 'ternjs/tern_for_vim', {
              \   'autoload' : { 'filetypes' : ['javascript'] }
              \}
        NeoBundle 'cohama/lexima.vim'
        NeoBundle 'Shougo/neosnippet'
        NeoBundle 'Shougo/neosnippet-snippets'
        NeoBundleLazy 'leafgarland/typescript-vim', {
              \   'autoload' : { 'filetypes' : ['typescript'] }
              \}
        NeoBundleLazy 'Rykka/riv.vim', {
              \   'autoload' : { 'filetypes' : ['rst'] }
              \}
        NeoBundleLazy 'Quramy/vim-js-pretty-template', {
              \   'autoload' : { 'filetypes' : ['javascript', 'typescript'] }
              \}
        NeoBundle 'Shougo/context_filetype.vim'
        NeoBundle 'osyo-manga/vim-precious'
        NeoBundle 'digitaltoad/vim-pug'
        NeoBundle 'tpope/vim-surround'
        NeoBundle 'junegunn/fzf'
        NeoBundle 'junegunn/fzf.vim'
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
        NeoBundle 'neomake/neomake'
        NeoBundle 'benjie/local-npm-bin.vim'
        NeoBundle 'rhysd/clever-f.vim'
        NeoBundle 'itchyny/lightline.vim'
        NeoBundle 'bronson/vim-trailing-whitespace'
        NeoBundleLazy 'tomlion/vim-solidity', {
              \   'autoload' : { 'filetypes' : ['solidity'] }
              \}
        NeoBundleLazy 'keith/swift.vim', {
              \   'autoload' : { 'filetypes' : ['swift'] }
              \}

        call neobundle#end()
endif

filetype plugin indent on

" confirm uninstalled plugins
NeoBundleCheck

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

" prevent editing readonly file
autocmd BufRead * let &modifiable = !&readonly


" confirm uninstalled plugins
NeoBundleCheck

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
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '$HOME/templates/previm/github.css'

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
      \    'start':
      \     '<script\%( [^>]*\)\? lang="\%(coffeescript\)"\%( [^>]*\)\?>',
      \    'end': '</script>', 'filetype': 'coffee',
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
let g:neomake_javascript_enabled_makers = ['myeslint']
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

" read local setting
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
