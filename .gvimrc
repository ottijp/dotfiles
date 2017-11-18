set showtabline=2
set transparency=5
set imdisable
set antialias
set nobackup
set visualbell t_vb=
set nowrapscan
set columns=100
set lines=48

colorscheme solarized

" read local setting
if filereadable(expand('~/.gvimrc.local'))
    source ~/.gvimrc.local
endif
