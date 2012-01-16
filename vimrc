
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages for Arch Linux
if has('unix') && ! has('macunix')
    runtime! archlinux.vim
endif

"Lines inspired from http://stevelosh.com/blog/2010/09/coming-home-to-vim/"
call pathogen#infect()

filetype plugin indent on

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
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
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

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" Convert tab to spaces and set tab to 4 spaces and set identation to 4 spaces"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Turn on syntax coloring and choose color scheme":
syntax enable

if ! has("gui_running") 
    set t_Co=256 
endif 
" feel free to choose :set background=light for a different style 
set background=dark 
colors zenburn 

if has('gui_running') && has('Mac')
  set guifont=Inconsolata:h16.00
endif

" Toggle line numbers and fold column for easy copying with 'F3':
nnoremap <F3> :setlocal nonumber!<CR>:set foldcolumn=0<CR>

" Toggle relative and absolute numbering with 'F4':
:nnoremap <F4> :setlocal <c-r>=&number ? "relativenumber" : "number"<cr><cr>

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Toggle NERDTree on and off with 'F2':
map <F2> :NERDTreeToggle<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null<CR><CR>

" For python auto-completion
""let g:pydiction_location = '~/.vim/bundle/pydiction-1.2/complete-dict'

" When vimrc is edited, reload it
if has('macunix')
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif has('unix')
    autocmd! bufwritepost vimrc source /etc/vimrc
endif

" leader shortcuts (also SPACE already mapped above)
    " to reload the the current file (e.g., the vimrc)
    " nnoremap <leader>r :so<space>%<CR>
    " toggle rainbow parenthesis
nnoremap <leader>r :RainbowParenthesesToggle<CR>
    " to save and open current file
nnoremap <leader>o :w<CR>:!open<space>%<CR>
    " to open new vertical split with new file
nnoremap <leader>n :vne<CR>
    " Fast editing of the .vimrc
if has('unix') && ! has('macunix')
    map <leader>e :e! /etc/vimrc<cr>
else
    map <leader>e :e! ~/.vimrc<cr>
endif
    " add blank lines in normal mode above or below current line
nnoremap <leader>- :put!=''<CR>
nnoremap <leader>= :put=''<CR>
inoremap <leader>- <ESC>:put!=''<CR>k$i
inoremap <leader>= <ESC>:put=''<CR>k$i
    " close all files without saving and save global session
nnoremap <leader>ww :qa!<CR>
    "save and close all files and save global session
nnoremap <leader>q :mksession! ~/.vim/Session.vim<CR>:wqa<CR>
    " leader t,b used by command-t
    " reselect text just pasted
nnoremap <leader>p V`]
    " open vertical split
nnoremap <leader>v <C-w>v<C-w>l
    " open horizontal split
nnoremap <leader>s <C-w>s<C-w>l

" commands to run at startup
"" let NERDTreeShowHidden=1
"" let NERDTreeShowBookmarks=1
"" au VimEnter * :NERDTreeToggle

function! RestoreSession()
  if has ('macunix') && argc() == 0 "vim called without arguments on Mac
    execute 'source ~/.vim/Session.vim'
  end
endfunction
autocmd VimEnter * call RestoreSession()

" if html file set jinja syntax
:au BufRead *.html :set syntax=jinja

