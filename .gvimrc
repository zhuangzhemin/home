" Modeline and Notes {{{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker nospell:
"
"   This is the personal .vimrc file of Zhemin.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   Modified from spf13-vim files by Steve Francia
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }}}

" Environment {{{

    " Identify platform {{{
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }}}

    " Basics {{{
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }}}

    " Windows Compatible {{{
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }}}
    
    " Arrow Key Fix {{{
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }}}

" }}}

" Use before config if available {{{
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }}}

" Use bundles config {{{
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }}}

" General {{{

    set background=dark         " Assume a dark background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    filetype plugin indent on   " Automatically detect file types.
    syntax enable               " Syntax highlighting
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    set selection=inclusive

    set diffopt+=vertical

    "CTRL-A and CTRL-X do not deal 0xx as octal value
    set nrformats-=octal


    " settings for encoding
    set encoding=utf-8
    "set fileencoding=utf-8
    set fileformats=unix,dos
    set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,bgk,euc-jp,euc-kr,latin1
    set termencoding=utf-8
    "set fileformats=unix

    if has("multi_byte")
        set encoding=utf-8
        "language english
        "language messages zh_CN.utf-8
        set fillchars+=stl:\ ,stlnc:\

        if WINDOWS()
            let &termencoding=&encoding
        endif

        set fencs=utf-8,gbk,chinese,latin1
        set formatoptions+=mM

        if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
            set ambiwidth=double
        endif

        set helplang=cn
    endif

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set nospell                           " Spell checking off
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:spf13_no_restore_cursor = 1
    if !exists('g:spf13_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " Setting up the directories {{{
        set backupext=.bak
        set nobackup                  " Don't use backup
        "set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:spf13_no_views = 1
        if !exists('g:spf13_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }}}

" }}}

" Vim UI {{{

    if filereadable(expand("~/.vim/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        let g:solarized_degrade=0
        color solarized             " Load a colorscheme
    elseif filereadable(expand("~/.vim/colors/zhemin.vim"))
        color zhemin             " Load a colorscheme
    else
        color desert
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if exists('g:bundle_status_line')
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    if exists("&relativenumber")
        set relativenumber
    endif
    set showmatch                   " Show matching brackets/parenthesis
    set magic
    nnoremap / /\v
    vnoremap / /\v
    set gdefault                    " Set g switch as default option for re
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    nohlsearch                      " No highlight after loading files
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    "set list
    set nolist
    set listchars=tab:?\ ,trail:\ ,extends:#,nbsp:. " Highlight problematic whitespace
    "set listchars=tab:?\ ,trail:\ ,extends:?,precedes:? " Highlight problematic whitespace
    "set foldmethod=manual          " set fold method to manual
    "set foldmethod=indent          " set fold method to indent
    set foldmethod=syntax           " set fold method to syntax
    set nofoldenable                " No fold when open files

" }}}

" Formatting {{{

    set formatoptions+=mM
    set linebreak
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    autocmd FileType php,javascript,html,css,python,vim,vimwiki  set fileformat=unix
    autocmd FileType text setlocal textwidth=78
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }}}

" Key (re)Mappings {{{

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following to your .vimrc.before.local file:
    "   let g:spf13_leader='\'
    if !exists('g:spf13_leader')
        let mapleader = ','
    else
        let mapleader=g:spf13_leader
    endif
    if !exists('g:spf13_localleader')
        let maplocalleader = '_'
    else
        let maplocalleader=g:spf13_localleader
    endif

    " The default mappings for editing and applying the spf13 configuration
    " are <leader>ev and <leader>sv respectively. Change them to your preference
    " by adding the following to your .vimrc.before.local file:
    "   let g:spf13_edit_config_mapping='<leader>ec'
    "   let g:spf13_apply_config_mapping='<leader>sc'
    if !exists('g:spf13_edit_config_mapping')
        let s:spf13_edit_config_mapping = '<leader>ev'
    else
        let s:spf13_edit_config_mapping = g:spf13_edit_config_mapping
    endif
    if !exists('g:spf13_apply_config_mapping')
        let s:spf13_apply_config_mapping = '<leader>sv'
    else
        let s:spf13_apply_config_mapping = g:spf13_apply_config_mapping
    endif

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_easyWindows = 1
    if !exists('g:spf13_no_easyWindows')
        nnoremap <C-J> <C-W>j<C-W>_
        nnoremap <C-K> <C-W>k<C-W>_
        nnoremap <C-L> <C-W>l<C-W>_
        nnoremap <C-H> <C-W>h<C-W>_
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    "noremap j gj
    "noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_wrapRelMotion = 1
    if !exists('g:spf13_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_fastTabs = 1
    if !exists('g:spf13_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:spf13_no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif

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

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "   let g:spf13_clear_search_highlight = 1
    "if exists('g:spf13_clear_search_highlight')
    "    nmap <silent> <leader>/ :nohlsearch<CR>
    "else
    "    nmap <silent> <leader>/ :set invhlsearch<CR>
    "endif
    nnoremap <leader><space> :noh<CR>


    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" }}}

" Key (re)Mappings for Zhemin {{{
    "noremap <tab> za
    noremap <leader>x q:
    nnoremap <leader>v V`]
    nnoremap <leader>v :Ve!<CR>
    nnoremap <leader>d :'a,'bd<ESC>
    nnoremap <leader>c <ESC>'av'b$y<ESC>
    nnoremap <leader>bs :browse saveas<CR>
    inoremap <C-h> <Left>
    inoremap <C-j> <Down>
    inoremap <C-K> <Up>
    inoremap <C-l> <Right>
    nnoremap <space> <C-f>
    nnoremap <C-o> <C-o><BAR>:set rnu<CR>
    nnoremap <C-i> <C-i><BAR>:set rnu<CR>
    nnoremap <C-]> <C-]><BAR>:set rnu<CR>
    noremap <F1> <ESC>
    noremap <F2> :set wrap!<BAR>set wrap?<CR>
    noremap <F3> :set spell!<BAR>set spell?<CR>
    noremap <F4> :set paste!<BAR>set paste?<CR>
    noremap <F5> :bp<CR>
    noremap <F6> :bn<CR>
    noremap <F8> :if (&rnu)<Bar> 
                \set nonu<Bar>set nornu<CR>
                \elseif(!&nu) <Bar> 
                \set nu<Bar><CR>
                \else <Bar> 
                \set rnu<Bar><CR>
                \endif<CR> 
    noremap <F9> :%!xxd<CR>
    noremap <F10> :%!xxd -r<CR>

    noremap  <Down>      gj
    noremap  <Up>        gk
    inoremap <Down> <CO>gj
    inoremap <Up>   <C-O>gk

    " Use CTRL-S for saving, also in Insert mode
    noremap <C-S>		:update<CR>
    vnoremap <C-S>		<C-C>:update<CR>
    inoremap <C-S>		<C-O>:update<CR>

    " <leader>a is Select all
    noremap <leader>a gggH<C-O>G
    inoremap <leader>a <C-O>gg<C-O>gH<C-O>G
    cnoremap <leader>a <C-C>gggH<C-O>G
    onoremap <leader>a <C-C>gggH<C-O>G
    snoremap <leader>a <C-C>gggH<C-O>G
    xnoremap <leader>a <C-C>ggVG

    " CTRL-Tab is Next window
    noremap <C-Tab> <C-W>w
    inoremap <C-Tab> <C-O><C-W>w
    cnoremap <C-Tab> <C-C><C-W>w
    onoremap <C-Tab> <C-C><C-W>w

    " backspace in Visual mode deletes selection
    vnoremap <BS> d

    " SHIFT-Del are Cut
    vnoremap <S-Del> "+x

    " CTRL-Insert are Copy
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    noremap <S-Insert>		"+gP
    cnoremap <S-Insert>		<C-R>+

    " Pasting blockwise and linewise selections is not possible in Insert and
    " Visual mode without the +virtualedit feature.  They are pasted as if they
    " were characterwise instead.
    " Uses the paste.vim autoload script.
    " Use CTRL-G u to have CTRL-Z only undo the paste.

    exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']

    inoremap <S-Insert>		<C-V>
    vnoremap <S-Insert>		<C-V>

    if (WINDOWS() && has("gui_running"))
        nnoremap <leader>fe :!start explorer .<CR>
        noremap <C-F12> :call Change_font_size_win('+')<BAR> :set guifont?<CR>
        noremap <C-F11> :call Change_font_size_win('-')<BAR> :set guifont?<CR>
    elseif (LINUX() || OSX()) && has("gui_running")
        noremap <C-F12> :call Change_font_size_linux('+')<BAR> :set guifont?<CR>
        noremap <C-F11> :call Change_font_size_linux('-')<BAR> :set guifont?<CR>
    endif


" }}}

" GUI Settings {{{

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if !exists("g:spf13_no_big_font")
            if LINUX() && has("gui_running")
                set guifont=Source\ Code\ Pro\ Regular\ 12,Courier\ New\ Regular\ 12
                set guifontwide=Source\ Han\ Sans\ HW\ SC\ 12
                "set guifontwide=Noto\ Sans\ Mono\ CJK\ SC\ 12
            elseif OSX() && has("gui_running")
                set guifont=Source\ Code\ Pro\ Regular\ 12,Courier\ New\ Regular\ 12
                set guifontwide=Source\ Han\ Sans\ HW\ SC\ 12
                "set guifontwide=Noto\ Sans\ Mono\ CJK\ SC\ 12
            elseif WINDOWS() && has("gui_running")
                set guifont=Source_Code_Pro:h12,Consolas:h12,Courier_New:h12
                set guifontwide=SimHei:h12
                "set guifontwide=Noto_Sans_Mono_CJK_SC:h12,SimHei:h12
            endif
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }}}

" Functions {{{

    " Initialize directories {{{
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
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
    " }}}

    " Strip whitespace {{{
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }}}

    " Shell command {{{
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }}}

    " quick edit/source .vimrc file {{{
    function! s:ExpandFilenameAndExecute(command, file)
        execute a:command . " " . expand(a:file, ":p")
    endfunction
     
    "execute "noremap " . s:spf13_edit_config_mapping " :call <SID>EditSpf13Config()<CR>"
    execute "noremap " . s:spf13_edit_config_mapping " <C-w><C-v><C-w>l:e ~/.vimrc<CR>"
    execute "noremap " . s:spf13_apply_config_mapping . " :source ~/.vimrc<CR>"
    " }}}

    " Change font size {{{
    function! Change_font_size_win(flag)
        if a:flag == "+"
            let &guifont = substitute(&guifont, ':h\zs\d\+', '\=submatch(0)+1', "")
            let &guifontwide = substitute(&guifontwide, ':h\zs\d\+',  '\=submatch(0)+1', "")
            return "guifont=".&guifont.";"."guifontwide=".&guifontwide
        elseif a:flag == "-"
            let &guifont = substitute(&guifont, ':h\zs\d\+', '\=submatch(0)-1', "")
            let &guifontwide = substitute(&guifontwide, ':h\zs\d\+',  '\=submatch(0)-1', "")
            return "guifont=".&guifont.";"."guifontwide=".&guifontwide
        else
            echo "illegal flag"
            return "guifont=".&guifont.";"."guifontwide=".&guifontwide
        endif
    endfunction
    function! Change_font_size_linux(flag)
        if a:flag == "+"
            let &guifont = substitute(&guifont, '\<\d\+\>', '\=submatch(0)+1', "")
            let &guifontwide = substitute(&guifontwide, '\<\d\+\>',  '\=submatch(0)+1', "")
            return "guifont=".&guifont.";"."guifontwide=".&guifontwide
        elseif a:flag == "-"
            let &guifont = substitute(&guifont, '\<\d\+\>', '\=submatch(0)-1', "")
            let &guifontwide = substitute(&guifontwide, '\<\d\+\>',  '\=submatch(0)-1', "")
            return "guifont=".&guifont.";"."guifontwide=".&guifontwide
        else
            echo "illegal flag"
            return "guifont=".&guifont.";"."guifontwide=".&guifontwide
        endif
    endfunction
    " }}}

" }}}

