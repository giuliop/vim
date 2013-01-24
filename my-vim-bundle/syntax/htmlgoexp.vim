" Vim syntax file
"bthomson / htmlgoexp.vim"
"https://gist.github.com/2640645"
"

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

runtime! syntax/goexp.vim
runtime! syntax/html.vim
"runtime! syntax/goexp.vim
unlet b:current_syntax

" Helps match inside CSS
syn region goTagBlock matchgroup=goTagDelim start=/{{-\?/ end=/-\?}}/ skipwhite containedin=ALLBUT,Comment
"syn region Comment2 start=+{{/\*+ end=+\*/}}+ skipwhite containedin=ALL

let b:current_syntax = "htmlgoexp"

" {{{ Matchit support
" Copied from html.vim. Makes matchit plugin treat this ft as html.
" HTML:  thanks to Johannes Zellner and Benji Fisher.
if exists("loaded_matchit")
    let b:match_ignorecase = 1
    let b:match_words = '<:>,' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif
" }}}
" {{{ Highlight erroneous whitespace
" Lifted from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red

" Show tabs that are not at the start of a line:
syn match ExtraWhitespace /[^\t]\zs\t\+/ containedin=ALL

" Show spaces used for indenting (use only tabs for indenting).
syn match ExtraWhitespace /^\t*\zs \+/ containedin=ALL
" }}}
