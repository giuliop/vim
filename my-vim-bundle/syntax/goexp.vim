" Vim syntax file
"bthomson / goexp.vim"
"https://gist.github.com/2640637"
"
if exists("b:current_syntax")
  finish
endif

syntax case match

syn region goTagBlock matchgroup=goTagDelim start=/{{-\?/ end=/-\?}}/ skipwhite containedin=ALLBUT,Comment
syn region Comment matchgroup=NONE start=+/\*+ end=+\*/+ skipwhite containedin=goTagBlock

"HiLink goTagDelim goTagDelim

hi goTagBlock ctermfg=5 cterm=NONE
hi goTagDelim ctermfg=2 cterm=bold
"HiLink goTagDelim goTagDelim

let b:current_syntax = "goexp"
