" Go specific settings

" reformat golang programs on save
autocmd BufWritePost *.go :silent Fmt

" don't show whitespaces for Go and godoc files
setlocal nolist
autocmd FileType godoc setlocal nolist

" Run golang program
map <leader>g :w<CR>:!go run %<CR>

" Run Godoc on keyword under cursor
map <leader>d <Plug>(godoc-keyword)

" Change = in := (cursor must be left of =)
map <leader>; ^f=i:<ESC>

" configure tagbar to use gotags
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
