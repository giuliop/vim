" Inspired from http://stevelosh.com/blog/2010/09/coming-home-to-vim/ and
" https://github.com/spf13/spf13-vim/blob/3.0/.vimrc

" General
    set nocompatible                "who cares about vi?
    set modelines=0                 "will not use modelines
    set ttyfast                     "Indicates a fast terminal connection

    " Determine OS
        let os=substitute(system('uname'), '\n', '', '')
        if os == 'Darwin' || os == 'Mac'
            let os='Mac'
        endif

" Setup Bundle Support through Vundle
" The next three lines ensure that the ~/.vim/bundle/ system works
    filetype on
    filetype off
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()

" Use bundles config file
    if filereadable(expand("~/.vim/vimrc.bundles"))
        source ~/.vim/vimrc.bundles
    endif

" System
    filetype plugin indent on       " Automatically detect file types.
    syntax enable                       " syntax highlighting
    scriptencoding utf-8

    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter') use :file! to see full message
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set history=1000                " Store a ton of history (default is 20)
    set hidden                      " allow buffer switching without saving

    " Setting up the directories
    set backup                      " backups are nice
    if has('persistent_undo')
        set undofile                "so is persistent undo
        set undolevels=1000         "maximum number of changes that can be undone
        set undoreload=10000        "maximum number lines to save for undo on a buffer reload
    endif

" Formatting
    set wrap                        " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspacehhhdelete indent

    " Remove trailing whitespaces and ^M chars
    autocmd FileType javascript,python autocmd BufWritePre <buffer> call StripTrailingWhitespace()


" Vim UI
    set title                       " set the terminal title
    set showmode                    " display the current mode
    set cursorline                  " highlight current line

    if has('cmdline_info')
        set ruler                   " show the ruler
        set showcmd                 " show partial commands in status line and selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\        " Filename
        set statusline+=%w%h%m%r    " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set relativenumber              " instead of absolute numbers
    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=3                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set list                        " show char listed below in listchars
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    set gdefault                    " apply global substitution to all occurrences in lines
    set colorcolumn=85              " show column to highlight long lines
    set splitright                  " new windows opens to the right

" Graphics
    if ! has("gui_running")
        set term=screen-256color
        set t_Co=256
    endif

    set background=dark
    colorscheme lucius
    LuciusDarkLowContrast

    if has('gui_running') && os == 'Mac'
        set guifont=Inconsolata:h16.00
    endif

    hi ColorColumn ctermbg=59 guibg=darkgrey

" Key (re)Mappings

    let mapleader = ","

    " normal regex, not Vim's one
    nmap / /\v
    vmap / /\v

    " comma to de-highlight search
    nmap <leader>m :noh<CR>
    imap <leader>m <ESC>:noh<CR>a

    " \ to move around bracket pairs
    nmap \ %
    vmap \ %

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nmap <S-y> y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    set pastetoggle=<leader>0           " pastetoggle (sane indentation on pastes)

    " Disable arrow keys and sane up and down
    imap <up> <nop>
    imap <down> <nop>
    imap <left> <nop>
    imap <right> <nop>
    nmap j gj
    nmap k gk

    " No more help staring by mistake
    map <F1> <ESC>

    " Some extra time savers
    nmap ; :
    imap kj <ESC>

    " move around with ctrl + movement key
    nmap <C-h> <C-w>h
    nmap <C-j> <C-w>j
    nmap <C-k> <C-w>k
    nmap <C-l> <C-w>l

    " resize with movement key
    nmap <left> <C-w>2>
    nmap <down> <C-w>2+
    nmap <up> <C-w>2-
    nmap <right> <C-w>2<

    " Use Ctrl-W to delete the previous word, Ctrl-U to delete a line, and Ctrl-Y
    " to paste what you've deleted back, all while remaining in insert mode
    imap <silent> <C-W> <C-\><C-O>db
    imap <silent> <C-U> <C-\><C-O>d0
    imap <silent> <C-Y> <C-R>"

    " visual shifting (does not exit Visual mode)
    vmap < <gv
    vmap > >gv

    " map <leader>ff to display all lines with keyword under cursor and ask which one to jump to
    nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " use space to replay macro 'q' (qq / q to start/stop recording)
    nmap <Space> @q

    " Toggle line numbers and fold column for easy copying
    nmap <leader>3 :setlocal nonumber!<CR>:set foldcolumn=0<CR>

    " Toggle relative and absolute numbering
    nmap <leader>4 :setlocal <c-r>=&number ? "relativenumber" : "number"<CR><CR>

    " allow the . to execute once for each line of a visual selection
    vmap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    map <leader>ww :w !sudo tee % > /dev/null<CR>

    " to save and open current file
    nmap <leader>o :w<CR>:!open<space>%<CR>

    " to open new vertical split with new file
    nmap <leader>n :vne<CR>

    " Fast editing of the .vimrc
    map <leader>e :e! ~/.vim/vimrc<CR>

    " add blank lines above or below current line in insert mode
    imap <leader>[ <ESC>m`:put!=''<CR>``a
    imap <leader>] <ESC>m`:put=''<CR>``a

    " open vertical split
    nmap <leader>v <C-w>v<C-w>l

    " open horizontal split
    nmap <leader>s <C-w>s<C-w>l

    " Ctrl+s to save and if needed de-highlght search and select autocomplete
    map <C-s> :noh<CR>:w<CR>
    imap <expr> <C-s>  pumvisible() ? "\<CR><ESC>:noh<CR>:w<CR>" : "\<ESC>:noh<CR>:w<CR>"

    " Ctrl+q to quit
    map <C-q> :q<CR>
    imap <C-q> <ESC>:q<CR>

    " mm to toggle mouse mde
    map mm :call MouseToggle()<CR>

" Plugins

    " Ctags
        set tags=./tags;/,~/.vimtags

    " Syntastic
         let g:syntastic_javascript_checker='jshint'

    " NerdTree
        map <leader>2 :NERDTreeToggle<CR>
        " let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1

    " Session List
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>

    " Buffer explorer
        nmap <leader>b :BufExplorer<CR>

    " JSON
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

    " PyMode
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0

    " ctrlp
        let g:ctrlp_working_path_mode = 'c'
        let g:ctrlp_map = '<c-t>'
        nmap <silent> <C-t> :CtrlPMixed<CR>
        let g:ctrlp_show_hidden = 1
        set wildignore+=*/..*
        let g:ctrlp_custom_ignore = {
                    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                    \ 'file': '\v\.(swp|so|zip)$', }

    " YankRing
        let g:yankring_history_dir = '~/.vim/'
        let g:yankring_min_element_length = 2
        "let g:yankring_enabled = 0

    " TagBar
        nmap <silent> <leader>tt :TagbarToggle<CR>

    " PythonMode
        " Disable if python support not present
        if !has('python')
           let g:pymode = 1
        endif

    " Fugitive
        nmap <silent> <leader>gs :Gstatus<CR>
        nmap <silent> <leader>gd :Gdiff<CR>
        nmap <silent> <leader>gc :Gcommit<CR>
        nmap <silent> <leader>gb :Gblame<CR>
        nmap <silent> <leader>gl :Glog<CR>
        nmap <silent> <leader>gp :Git push<CR>

    " OmniComplete
        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        imap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        "imap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        "imap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        "imap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        imap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        imap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,menuone,preview,longest

    " neocomplcache
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_auto_delimiter = 1
        let g:neocomplcache_max_list = 15
        let g:neocomplcache_force_overwrite_completefunc = 1

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

        " Plugin key-mappings.
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        imap <expr><C-g> neocomplcache#undo_completion()
        imap <expr><C-l> neocomplcache#complete_common_string()

        " <C-h>, <BS>: close popup and delete backword char.
        imap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        imap <expr><C-y> neocomplcache#close_popup()

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " use honza's snippets
        let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif


" Automatic commands

    if has("autocmd")
        " disable automatic commenting of lines after comments
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

        " always switch to the current file directory.
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

        " HTML tabs to two spaces, no wrap, no expand tab to spaces, no show whitespaces
        autocmd FileType html setlocal noexpandtab shiftwidth=2 tabstop=2 softtabstop=2 nowrap nolist

        " When vimrc is edited, reload it
        autocmd! bufwritepost vimrc source ~/.vimrc

    endif

" Functions

    " Set up centralized directories for vim temp files
    function! InitializeDirectories()
        let separator = "."
        let home = $HOME
        let parent = home . '/' . '.vim'
        let prefix = '.vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/' . prefix . dirname . "/"
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()

    " Strip whitespace
    function! StripTrailingWhitespace()
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction

    " Toggle mouse mpde
    function! MouseToggle()
        if &mouse == ""
            let &mouse="a"
        else
            let &mouse=""
        endif
    endfunction
