" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
" godoc.vim: Vim command to see godoc.

if exists("g:loaded_godoc2")
  finish
endif
let g:loaded_godoc2 = 1

let s:buf_nr = -1
let s:last_word = ''

function! s:GodocView()
  if !bufexists(s:buf_nr)
    rightbelow vnew
    file `="[Godoc]"`
    let s:buf_nr = bufnr('%')
  elseif bufwinnr(s:buf_nr) == -1
    rightbelow vsplit
    execute s:buf_nr . 'buffer'
    delete _
  elseif bufwinnr(s:buf_nr) != bufwinnr('%')
    execute bufwinnr(s:buf_nr) . 'wincmd w'
  endif

  setlocal filetype=godoc
  setlocal bufhidden=delete
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal nobuflisted
  setlocal modifiable
  setlocal nocursorline
  setlocal nocursorcolumn
  setlocal iskeyword+=:
  setlocal iskeyword-=-

  nnoremap <buffer> <silent> K :Godoc<cr>

  au BufHidden <buffer> call let <SID>buf_nr = -1
endfunction

function! s:GodocWord(word)
  let word = a:word
  silent! let content = system('godoc ' . word)
  if v:shell_error || !len(content)
    if len(s:last_word)
      silent! let content = system('godoc ' . s:last_word.'/'.word)
      if v:shell_error || !len(content)
        echo 'No documentation found for "' . word . '".'
        return
      endif
      let word = s:last_word.'/'.word
    else
      echo 'No documentation found for "' . word . '".'
      return
    endif
  endif
  let s:last_word = word
  silent! call s:GodocView()
  setlocal modifiable
  silent! %d _
  silent! put! =content
  silent! normal gg
  setlocal nomodifiable
  setfiletype godoc
endfunction

function! s:Godoc(...)
  let word = join(a:000, ' ')
  if !len(word)
    let word = expand('<cword>')
    let m = matchlist(getbufline("", line(".")), '\(\w*\)\([/.]\)' . word . '[^-_[:alnum:]]*')
    if !empty(m)
        if m[2] == "."
            let package = s:AddParent(m[1])
            let word = package . ' ' . word
        elseif m[2] == "/"
            let word = m[1] . "/" . word
        endif
    else
        let word = s:AddParent(word)
    endif
  endif
  if !len(word)
    return
  endif
  call s:GodocWord(word)
  "echo word
endfunction

function! s:AddParent(ident)
    let ident = a:ident
    let save_cursor = getpos(".")
    call cursor(1,1)
    let import_line = search('^import', '', save_cursor[1])
    if !search('(', 'n', import_line)
        let import_endline = import_line
    else
        let import_endline = search(')', 'n')
    endif
    if search(ident, '', import_endline)
        let ident = expand('<cWORD>')
        let ident = ident[1:len(ident)-2]
    endif
    call setpos('.', save_cursor)
    return ident
endfunction

command! -nargs=* -range -complete=customlist,go#complete#Package Godoc :call s:Godoc(<q-args>)
nnoremap <silent> <Plug>(godoc-keyword) :<C-u>call <SID>Godoc('')<CR>

" vim:ts=4:sw=4:et
