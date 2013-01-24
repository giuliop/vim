" Go specific settings

" reformat golang programs on save
autocmd BufWritePost * :silent Fmt

" don't show whitespaces for golang, html
setlocal nolist

" Run golang program
map <leader>g :w<CR>:!go run %<CR>

" Change = in := (cursor must be left of =)
map <leader>; ^f=i:<ESC>
