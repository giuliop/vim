" Go specific settings

" don't show whitespaces for Go and godoc files
setlocal nolist
autocmd FileType godoc setlocal nolist

" Change = in := (cursor must be left of =)
map <leader>; ^f=i:<ESC>

" if err != nil snippet
<<<<<<< HEAD
map <leader>6 oif err != nil {<CR>return err<CR>}<ESC>kk3=jjj
=======
map <leader>6 iif err != nil {<CR>return err<CR>}<ESC>kk3=jj
>>>>>>> 5df92e88a003bdb0c969c267fd1a2ad7f97b1c11
