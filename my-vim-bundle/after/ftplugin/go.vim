" Go specific settings

" don't show whitespaces for Go and godoc files
setlocal nolist
autocmd FileType godoc setlocal nolist

" Change = in := (cursor must be left of =)
map <leader>; ^f=i:<ESC>
