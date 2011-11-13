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

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap ; :
inoremap kj <ESC>

set splitright

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Convert tab to spaces and set tab to 4 spaces and set identation to 4 spaces"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Turn on syntax coloring and choose color scheme":
syntax enable
set background=dark
colorscheme peaksea
set guifont=Monaco:h15.00

" Toggle line numbers and fold column for easy copying with 'F3':
nnoremap <F3> :set nonumber!<CR>:set foldcolumn=0<CR>

" Toggle NERDTree on and off
map <F2> :NERDTreeToggle<CR>

" For python auto-completion
""let g:pydiction_location = '~/.vim/bundle/pydiction-1.2/complete-dict'

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" leader shortcuts
    " to reload the the current file (e.g., the.vimrc)
nnoremap <leader>r :so<space>%<CR>
    " to save and open current file
nnoremap <leader>o :w<CR>:!open<space>%<CR>
    " to open new vertical split with new file
nnoremap <leader>n :vne<CR>
    " Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>
    " toggle background
map <leader>g :let &background = ( &background == "dark"? "light" : "dark" )<CR>
    " resize
map <leader>s :vertical resize 89<CR> 
    " close all files without saving and save global session
nnoremap <leader>ww :qa!<CR>
    "save and close all files and save global session
nnoremap <leader>q :mksession! ~/.vim/Session.vim<CR>:wqa<CR>
    " leader t,b used by command-t

" commands to run at startup
"" let NERDTreeShowHidden=1
"" let NERDTreeShowBookmarks=1
"" au VimEnter * :NERDTreeToggle

function! RestoreSession()
  if argc() == 0 "vim called without arguments
    execute 'source ~/.vim/Session.vim'
  end
endfunction
autocmd VimEnter * call RestoreSession()

" if html file set jinja syntax
:au BufRead *.html :set syntax=jinja

