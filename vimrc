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

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages for Arch Linux
    if os == 'Linux' && filereadable(expand("~/.vim/archlinux.vim"))
        runtime! ~/.vim/archlinux.vim
    endif

" Lines inspired from http://stevelosh.com/blog/2010/09/coming-home-to-vim/ and
" https://github.com/spf13/spf13-vim/blob/3.0/.vimrc

" Formatting
    set wrap                        " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent

    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

" System
    filetype plugin indent on       " Automatically detect file types.
    syntax on                       " syntax highlighting
    scriptencoding utf-8
    "set mouse=a                     " automatically enable mouse usage
    "set mousehide                   " hide the mouse cursor while typing

    " set autowrite                   " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    "set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    " set spell                       " spell checking on
    set hidden                      " allow buffer switching without saving

    " Setting up the directories
    set backup                      " backups are nice ...
    if has('persistent_undo')
        set undofile                "so is persistent undo ...
        set undolevels=1000         "maximum number of changes that can be undone
        set undoreload=10000        "maximum number lines to save for undo on a buffer reload
    endif


" Vim UI
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode
    set cursorline                  " highlight current line

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\        " Filename
        set statusline+=%w%h%m%r    " Options
        "set statusline+=%{fugitive#statusline()} " Git Hotness
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
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set list                        " show char listed below in listchars
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    set gdefault                        " apply global substitution to all occurrences in lines
    set colorcolumn=85
    set splitright
    " set colorcolumn color
    hi ColorColumn ctermbg=darkgrey guibg=darkgrey
    " set formatoptions=qn1

" Graphics
    if ! has("gui_running") 
        set term=screen-256color
        set t_Co=256
        "set term=$TERM              " Make arrow and other keys work
    endif

    colorscheme Tomorrow-Night

    if has('gui_running') && os == 'Mac'
        set guifont=Inconsolata:h16.00
    endif

" Key (re)Mappings

    let mapleader = ","

    " normal regex, not Vim's one
    nnoremap / /\v
    vnoremap / /\v

    " comma to de-highlight search
    nnoremap <leader>m :noh<cr>
    inoremap <leader>m <ESC>:noh<cr>a

    " Enter to move around bracket pairs
    nnoremap <CR> %
    vnoremap <CR> %

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

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
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>
    nnoremap j gj
    nnoremap k gk

    " No more help staring by mistake
    noremap <F1> <ESC>
    nnoremap <F1> <ESC>
    vnoremap <F1> <ESC>

    " Some extra time savers
    nnoremap ; :
    inoremap kj <ESC>

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

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " map <leader>ff to display all lines with keyword under cursor and ask which one to jump to
    nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " use space to replay macro 'q' (qq / q to start/stop recording)
    :nnoremap <Space> @q

    " Toggle line numbers and fold column for easy copying
    nnoremap <leader>3 :setlocal nonumber!<CR>:set foldcolumn=0<CR>

    " Toggle relative and absolute numbering
    nnoremap <leader>4 :setlocal <c-r>=&number ? "relativenumber" : "number"<cr><cr>

    " allow the . to execute once for each line of a visual selection
    vnoremap . :normal .<CR>

    " to reload the the current file (e.g., the vimrc)
    " nnoremap <leader>r :so<space>%<CR>

    " For when you forget to sudo.. Really Write the file.
    noremap <leader>ww :w !sudo tee % > /dev/null<CR>

    " to save and open current file
    nnoremap <leader>o :w<CR>:!open<space>%<CR>

    " to open new vertical split with new file
    nnoremap <leader>n :vne<CR>

    " Fast editing of the .vimrc
    map <leader>e :e! ~/.vimrc<cr>

    " add blank lines above or below current line
    "nnoremap <leader>- m`:put!=''<CR>``
    "nnoremap <leader>= m`:put=''<CR>``
    "inoremap <leader>- <ESC>m`:put!=''<CR>``a
    "inoremap <leader>= <ESC>m`:put=''<CR>``a

    " close all files without saving and save global session
    "nnoremap <leader>ww :qa!<CR>
    "save and close all files and save global session
    "nnoremap <leader>q :mksession! ~/.vim/Session.vim<CR>:wqa<CR>

    " reselect text just pasted
    " nnoremap <leader>"choose a letter" V`]

    " open vertical split
    nnoremap <leader>v <C-w>v<C-w>l

    " open horizontal split
    nnoremap <leader>s <C-w>s<C-w>l

    " Ctrl+s to save and de-highlght search if needed
    map <C-s> :noh<cr>:w<cr>
    imap <expr> <C-s>  pumvisible() ? "\<cr><ESC>:noh<cr>:w<cr>" : "<ESC>:noh<cr>:w<cr>"

    " Ctrl+q to quit, hold shift to discard changes
    map <C-q> :q<cr>
    imap <C-q> <ESC>:q<cr>
    map <C-S-q> :q!<cr>
    imap <C-S-q> <ESC>:q!<cr>

" Plugins

    " Ctags
        set tags=./tags;/,~/.vimtags

    " Syntastic
         let g:syntastic_javascript_checker='jshint'

    " OmniComplete
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest

    " NerdTree
        map <leader>2 :NERDTreeToggle<CR>
        map <leader>1 :NERDTreeFind<CR>

        " let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1

    " Tabularize
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

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
        nnoremap <silent> <C-t> :CtrlPMixed<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }

        "let g:ctrlp_user_command = {
            "\ 'types': {
                "\ 1: ['.git', 'cd %s && git ls-files'],
                "\ 2: ['.hg', 'hg --cwd %s locate -I .'],
            "\ },
            "\ 'fallback': 'find %s -type f'

    " YankRing
       let g:yankring_history_dir = '~/.vim/'
       let g:yankring_min_element_length = 2

    " TagBar
        nnoremap <silent> <leader>tt :TagbarToggle<CR>

    " PythonMode
        " Disable if python support not present
        if !has('python')
           let g:pymode = 1
        endif

    " Fugitive
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>

    " neocomplcache
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_enable_auto_delimiter = 1
        let g:neocomplcache_max_list = 15
        let g:neocomplcache_force_overwrite_completefunc = 1

        " SuperTab like snippets behavior.
        imap <silent><expr><TAB> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-e>" : "\<TAB>")
        smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns._ = '\h\w*'

        " Plugin key-mappings.
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        inoremap <expr><C-g> neocomplcache#undo_completion()
        inoremap <expr><C-l> neocomplcache#complete_common_string()
        inoremap <expr><CR> neocomplcache#complete_common_string()

        " <TAB>: completion.
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
        inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplcache#close_popup()

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

        " use honza's snippets
        let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif


" Automatic commands

        " always switch to the current file directory.
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    if has("autocmd")
        " disable automatic commenting of lines after comments
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

        " Treat .json files as .js
        autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

        " if html file set jinja syntax
        autocmd BufRead *.html :set syntax=jinja

        " HTML tabs to two spaces and no wrap
        autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 nowrap

        " When vimrc is edited, reload it
        autocmd! bufwritepost .vimrc source ~/.vimrc
    endif

" Functions

    function! UnBundle(arg, ...)
      let bundle = vundle#config#init_bundle(a:arg, a:000)
      call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
    endfunction

    com! -nargs=+         UnBundle
    \ call UnBundle(<args>)

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

    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction

    " Strip whitespace
    function! StripTrailingWhitespace()
        " To disable the stripping of whitespace, add the following to your
        " .vimrc.local file:
        "   let g:spf13_keep_trailing_whitespace = 1
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

