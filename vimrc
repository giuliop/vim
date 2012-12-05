" Determine OS
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    let os='Mac'
endif

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages for Arch Linux
if os == 'Linux'
    runtime! archlinux.vim
endif

"Lines inspired from http://stevelosh.com/blog/2010/09/coming-home-to-vim/"
call pathogen#infect()

set nocompatible

set modelines=0

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

let mapleader = ","

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader>, :noh<cr>
inoremap <leader>, <ESC>:noh<cr>a
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qn1

set colorcolumn=80

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

noremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap ; :
inoremap kj <ESC>

set splitright

" move around with ctrl + movement key
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" resize with shift + movement key 
nnoremap <left> <C-w>2>
nnoremap <down> <C-w>2+
nnoremap <up> <C-w>2-
nnoremap <right> <C-w>2<

" Use Ctrl-W to delete the previous word, Ctrl-U to delete a line, and Ctrl-Y 
" to paste what you've deleted back, all while remaining in insert mode
inoremap <silent> <C-W> <C-\><C-O>db
inoremap <silent> <C-U> <C-\><C-O>d0
inoremap <silent> <C-Y> <C-R>"

" Set status bar
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" Convert tab to spaces and set tab to 4 spaces and set identation to 4 spaces"
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

if ! has("gui_running") 
    set t_Co=256 
endif 

" Turn on syntax coloring and choose color scheme":
syntax enable
set background=dark 
"colorscheme zenburn 
colorscheme Tomorrow-Night

if has('gui_running') && os == 'Mac'
  set guifont=Inconsolata:h16.00
endif

" use space to replay macro 'q' (qq / q to start/stop recording)
:nnoremap <Space> @q

" set colorcolumn color
hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" Toggle line numbers and fold column for easy copying
nnoremap <leader>3 :setlocal nonumber!<CR>:set foldcolumn=0<CR>

" Toggle relative and absolute numbering
nnoremap <leader>4 :setlocal <c-r>=&number ? "relativenumber" : "number"<cr><cr>

" Toggle TagBar
nmap <leader>8 :TagbarToggle<CR>

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Toggle NERDTree on and off
map <leader>2 :NERDTreeToggle<CR>

" leader shortcuts (also SPACE already mapped above)
    " to reload the the current file (e.g., the vimrc)
    " nnoremap <leader>r :so<space>%<CR>
" For when you forget to sudo.. Really Write the file.
noremap <leader>ww :w !sudo tee % > /dev/null<CR>
    " toggle rainbow parenthesis
nnoremap <leader>r :RainbowParenthesesToggle<CR>
nnoremap <leader>[[ :RainbowParenthesesLoadSquare<CR>
nnoremap <leader>[ :RainbowParenthesesLoadBraces<CR>
    " to save and open current file
nnoremap <leader>o :w<CR>:!open<space>%<CR>
    " to open new vertical split with new file
nnoremap <leader>n :vne<CR>
    " Fast editing of the .vimrc
if os == 'Linux'
    map <leader>e :e! /etc/vimrc<cr>
else
    map <leader>e :e! ~/.vimrc<cr>
endif
    " add blank lines above or below current line
nnoremap <leader>- m`:put!=''<CR>``
nnoremap <leader>= m`:put=''<CR>``
inoremap <leader>- <ESC>m`:put!=''<CR>``a
inoremap <leader>= <ESC>m`:put=''<CR>``a
    " close all files without saving and save global session
"nnoremap <leader>ww :qa!<CR>
    "save and close all files and save global session
"nnoremap <leader>q :mksession! ~/.vim/Session.vim<CR>:wqa<CR>
    " leader t,b used by command-t
    " reselect text just pasted
nnoremap <leader>p V`]
    " open vertical split
nnoremap <leader>v <C-w>v<C-w>l
    " open horizontal split
nnoremap <leader>s <C-w>s<C-w>l
" Ctrl+s to save
map <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>a

" Ctrl+q to quit, hold shift to discard changes
map <C-q> :q<cr>
imap <C-q> <ESC>:q<cr>
map <C-S-q> :q!<cr>
imap <C-S-q> <ESC>:q!<cr>

" commands to run at startup
" remap sparkup next tag command to avoid conflict with any word completion
let g:sparkupNextMapping = '<C-x>'
" let NERDTreeShowHidden=1
" let NERDTreeShowBookmarks=1
" au VimEnter * :NERDTreeToggle

"function! RestoreSession()
  "if has ('macunix') && argc() == 0 "vim called without arguments on Mac
    "execute 'source ~/.vim/Session.vim'
  "end
"endfunction
"autocmd VimEnter * call RestoreSession()

" Enable file type detection
filetype indent plugin on

" Automatic commands
if has("autocmd")
    " disable automatic commenting of lines after comments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " if html file set jinja syntax
    :au BufRead *.html :set syntax=jinja
    " HTML tabs to two spaces and no wrap
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 nowrap
    " When vimrc is edited, reload it
    if os == 'Mac'
        autocmd! bufwritepost .vimrc source ~/.vimrc
    elseif os == 'Linux'
        autocmd! bufwritepost vimrc source /etc/vimrc
    endif
    " enable javascript folding
    function! JavaScriptFold() 
        setl foldmethod=syntax
        setl foldlevel=1
        syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

        function! FoldText()
            return substitute(getline(v:foldstart), '{.*', '{...}', '')
        endfunction
        setl foldtext=FoldText()
    endfunction
    au FileType javascript call JavaScriptFold()
    au FileType javascript setl fen
    autocmd BufWinLeave *.js mkview "to save folding on exit
    autocmd BufWinEnter *.js silent loadview "to load folding on entry
endif
