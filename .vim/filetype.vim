if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.jade setfiletype pug
  au! BufRead,BufNewFile *.uml,*.pu,*.plantuml setfiletype plantuml
augroup END
