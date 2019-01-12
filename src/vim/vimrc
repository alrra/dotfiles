" ----------------------------------------------------------------------
" | General Settings                                                   |
" ----------------------------------------------------------------------

set nocompatible               " Don't make Vim vi-compatibile.

syntax on                      " Enable syntax highlighting.

if has("autocmd")
    filetype plugin indent on
    "           │     │    └──── Enable file type detection.
    "           │     └───────── Enable loading of indent file.
    "           └─────────────── Enable loading of plugin files.
endif

set autoindent                 " Copy indent to the new line.

set backspace=indent           " ┐
set backspace+=eol             " │ Allow `backspace`
set backspace+=start           " ┘ in insert mode.

set backupdir=~/.vim/backups   " Set directory for backup files.

set backupskip=/tmp/*          " ┐ Don't create backups
set backupskip+=/private/tmp/* " ┘ for certain files.

set clipboard=unnamed          " ┐
                               " │ Use the system clipboard
if has("unnamedplus")          " │ as the default register.
    set clipboard+=unnamedplus " │
endif                          " ┘

set cpoptions+=$               " When making a change, don't
                               " redisplay the line, and instead,
                               " put a `$` sign at the end of
                               " the changed text.

set colorcolumn=73             " Highlight certain column(s).
set cursorline                 " Highlight the current line.
set directory=~/.vim/swaps     " Set directory for swap files.
set encoding=utf-8 nobomb      " Use UTF-8 without BOM.
set history=5000               " Increase command line history.
set hlsearch                   " Enable search highlighting.
set ignorecase                 " Ignore case in search patterns.

set incsearch                  " Highlight search pattern
                               " as it is being typed.

set laststatus=2               " Always show the status line.

set lazyredraw                 " Do not redraw the screen while
                               " executing macros, registers
                               " and other commands that have
                               " not been typed.

set listchars=tab:▸\           " ┐
set listchars+=trail:·         " │ Use custom symbols to
set listchars+=eol:↴           " │ represent invisible characters.
set listchars+=nbsp:_          " ┘

set magic                      " Enable extended regexp.
set mousehide                  " Hide mouse pointer while typing.
set noerrorbells               " Disable error bells.

set nojoinspaces               " When using the join command,
                               " only insert a single space
                               " after a `.`, `?`, or `!`.

set nostartofline              " Kept the cursor on the same column.
set number                     " Show line number.

set numberwidth=5              " Increase the minimal number of
                               " columns used for the `line number`.

set report=0                   " Report the number of lines changed.
set ruler                      " Show cursor position.

set scrolloff=5                " When scrolling, keep the cursor
                               " 5 lines below the top and 5 lines
                               " above the bottom of the screen.

set shortmess=aAItW            " Avoid all the hit-enter prompts.
set showcmd                    " Show the command being typed.
set showmode                   " Show current mode.
set spelllang=en_us            " Set the spellchecking language.

set smartcase                  " Override `ignorecase` option
                               " if the search pattern contains
                               " uppercase characters.

set synmaxcol=2500             " Limit syntax highlighting (this
                               " avoids the very slow redrawing
                               " when files contain long lines).

set tabstop=4                  " ┐
set softtabstop=4              " │ Set global <TAB> settings.
set shiftwidth=4               " │
set expandtab                  " ┘

set ttyfast                    " Enable fast terminal connection.
set undodir=~/.vim/undos       " Set directory for undo files.
set undofile                   " Automatically save undo history.
set virtualedit=all            " Allow cursor to be anywhere.

set visualbell                 " ┐
set noerrorbells               " │ Disable beeping and window flashing
set t_vb=                      " ┘ https://vim.wikia.com/wiki/Disable_beeping

set wildmenu                   " Enable enhanced command-line
                               " completion (by hitting <TAB> in
                               " command mode, Vim will show the
                               " possible matches just above the
                               " command line with the first
                               " match highlighted).

set winminheight=0             " Allow windows to be squashed.


" ----------------------------------------------------------------------
" | Plugins                                                            |
" ----------------------------------------------------------------------

" Use `minpac` to manage the Vim plugins.
" https://github.com/k-takata/minpac

function! InitPlugins() abort

    packadd minpac

    call minpac#init()
    call minpac#add('k-takata/minpac', { 'type': 'opt' })

    call minpac#add('altercation/vim-colors-solarized')
    call minpac#add('ap/vim-css-color')
    call minpac#add('chrisbra/unicode.vim')
    call minpac#add('editorconfig/editorconfig-vim')
    call minpac#add('godlygeek/tabular')
    call minpac#add('isRuslan/vim-es6')
    call minpac#add('jelera/vim-javascript-syntax')
    call minpac#add('kien/ctrlp.vim')
    call minpac#add('marijnh/tern_for_vim', { 'do': ':silent ! cd $HOME/.vim/pack/minpac/start/tern_for_vim && npm i &> /dev/null' })
    call minpac#add('mattn/emmet-vim')
    call minpac#add('mattn/webapi-vim')
    call minpac#add('mhinz/vim-signify')
    call minpac#add('moll/vim-node')
    call minpac#add('mtscout6/syntastic-local-eslint.vim')
    call minpac#add('nathanaelkane/vim-indent-guides')
    call minpac#add('raimondi/delimitmate')
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('scrooloose/syntastic')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('shougo/neocomplcache.vim')
    call minpac#add('shougo/neosnippet')
    call minpac#add('shougo/neosnippet-snippets')
    call minpac#add('suan/vim-instant-markdown')
    call minpac#add('thiagoalessio/rainbow_levels.vim')
    call minpac#add('tomtom/tcomment_vim')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('wellle/targets.vim')

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Define custom commands for managing plugins.

command! PluginsClean   call InitPlugins() | call minpac#clean()
command! PluginsSetup   call InitPlugins() | call minpac#update('', {'do': 'quit'})
command! PluginsStatus  call InitPlugins() | call minpac#status()
command! PluginsUpdate  call InitPlugins() | call minpac#update('', {'do': 'call minpac#status()'})

" ----------------------------------------------------------------------
" | Plugins - Emmet                                                    |
" ----------------------------------------------------------------------

" Redefine trigger key for Emmet.
" http://docs.emmet.io/cheat-sheet/

let g:user_emmet_leader_key="<C-E>"

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Load custom Emmet snippets.
" http://docs.emmet.io/customization/snippets/

if exists('webapi#json')
    let g:user_emmet_settings = webapi#json#decode(join(readfile(expand("~/.vim/snippets/emmet.json")), "\n"))
endif


" ----------------------------------------------------------------------
" | Plugins - Indent Guides                                            |
" ----------------------------------------------------------------------

" Set custom indent colors.
" https://github.com/nathanaelkane/vim-indent-guides#setting-custom-indent-colors

let g:indent_guides_auto_colors = 0

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd
        \ guibg=#00323D
        \ ctermbg=Magenta

autocmd VimEnter,Colorscheme * :hi IndentGuidesEven
        \ guibg=#073642
        \ ctermbg=DarkMagenta


" ----------------------------------------------------------------------
" | Plugins - Instant Markdown                                         |
" ----------------------------------------------------------------------

" Do not automatically launch the preview
" window when the markdown file is open.
" https://github.com/suan/vim-instant-markdown#ginstant_markdown_autostart

let g:instant_markdown_autostart = 0


" ----------------------------------------------------------------------
" | Plugins - Markdown                                                 |
" ----------------------------------------------------------------------

" Disable Folding.
" https://github.com/plasticboy/vim-markdown#disable-folding

let g:vim_markdown_folding_disabled=1


" ----------------------------------------------------------------------
" | Plugins - NeoComplCache                                            |
" ----------------------------------------------------------------------

" Enable `neocomplcache` by default.
" https://github.com/Shougo/neocomplcache.vim#installation

let g:neocomplcache_enable_at_startup=1

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Make `Tab` autocomplete.

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Make `Shift+Tab` insert `Tab` character.

inoremap <S-TAB> <C-V><TAB>

" ----------------------------------------------------------------------
" | Plugins - Signify                                                  |
" ----------------------------------------------------------------------

" Disable Signify by default.
" https://github.com/mhinz/vim-signify

let g:signify_disable_by_default=1


" ----------------------------------------------------------------------
" | Plugins - Syntastic                                                |
" ----------------------------------------------------------------------

" Inform Syntastic which checkers to use based on file types.
" https://github.com/scrooloose/syntastic#faq

let g:syntastic_javascript_checkers = [ 'eslint' ]

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Disable syntax checking by default.

let g:syntastic_mode_map = {
    \ "active_filetypes": [],
    \ "mode": "passive",
    \ "passive_filetypes": []
\}


" ----------------------------------------------------------------------
" | Helper Functions                                                   |
" ----------------------------------------------------------------------

function! GetGitBranchName()

    let branchName = ""

    if exists("g:loaded_fugitive")
        let branchName = "[" . fugitive#head() . "]"
    endif

    return branchName

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! StripTrailingWhitespaces()

    " Save last search and cursor position.

    let searchHistory = @/
    let cursorLine = line(".")
    let cursorColumn = col(".")

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Strip trailing whitespaces.

    %s/\s\+$//e

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Restore previous search history and cursor position.

    let @/ = searchHistory
    call cursor(cursorLine, cursorColumn)


endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleLimits()

    " [51,73]
    "
    "   * Git commit message
    "     http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
    "
    " [81]
    "
    "   * general use

    if ( &colorcolumn == "73" )
        set colorcolumn+=51,81
    else
        set colorcolumn-=51,81
    endif

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleRelativeLineNumbers()

    if ( &relativenumber == 1 )
        set number
    else
        set relativenumber
    endif

endfunction


" ----------------------------------------------------------------------
" | Automatic Commands                                                 |
" ----------------------------------------------------------------------

if has("autocmd")

    " Autocommand Groups.
    " http://learnvimscriptthehardway.stevelosh.com/chapters/14.html

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Automatically reload the configurations from
    " the `~/.vimrc` file whenever they are changed.

    augroup auto_reload_vim_configs

        autocmd!
        autocmd BufWritePost vimrc source $MYVIMRC

    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Use relative line numbers.
    " http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/

    augroup relative_line_numbers

        autocmd!

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to absolute
        " line numbers when Vim loses focus.

        autocmd FocusLost * :set number

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to relative
        " line numbers when Vim gains focus.

        autocmd FocusGained * :set relativenumber

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to absolute
        " line numbers when Vim is in insert mode.

        autocmd InsertEnter * :set number

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to relative
        " line numbers when Vim is in normal mode.

        autocmd InsertLeave * :set relativenumber


    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Automatically strip the trailing
    " whitespaces when files are saved.

    augroup strip_trailing_whitespaces

        " List of file types for which the trailing whitespaces
        " should not be removed:

        let excludedFileTypes = []

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Only strip the trailing whitespaces if
        " the file type is not in the excluded list.

        autocmd!
        autocmd BufWritePre * if index(excludedFileTypes, &ft) < 0 | :call StripTrailingWhitespaces()

    augroup END

endif


" ----------------------------------------------------------------------
" | Color Scheme                                                       |
" ----------------------------------------------------------------------

set t_Co=256                   " Enable full-color support.

set background=dark            " Use colors that look good
                               " on a dark background.

" Set custom configurations for when the
" Solarized theme is used from Vim's Terminal mode.
"
" https://github.com/altercation/vim-colors-solarized

if !has("gui_running")
    let g:solarized_contrast = "high"
    let g:solarized_termcolors = 256
    let g:solarized_termtrans = 1
    let g:solarized_visibility = "high"
endif

silent! colorscheme solarized  " Use custom color scheme.

" ----------------------------------------------------------------------
" | Key Mappings                                                       |
" ----------------------------------------------------------------------

" Use a different mapleader (default is "\").

let mapleader = ","

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,* ] Search and replace the word under the cursor.

nmap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cc] Toggle code comments.
" https://github.com/tomtom/tcomment_vim

map <leader>cc :TComment<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cr] Calculate result.
" http://vimcasts.org/e/56

nmap <leader>cr 0yt=A<C-r>=<C-r>"<CR><Esc>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cs] Clear search.

map <leader>cs <Esc>:noh<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,gd] Toggle Git differences.

map <leader>gd :SignifyToggle<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,l ] Toggle `set list`.

nmap <leader>l :set list!<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,n ] Toggle `set relativenumber`.

nmap <leader>n :call ToggleRelativeLineNumbers()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,rl ] Toggle `RainbowLevels`.

map <leader>rl :RainbowLevelsToggle<cr>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,sh] Show hex dump.

nmap <leader>sh :%!xxd<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,sr] Strip carriage returns.

nmap <leader>sr :%s/\r//g<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ss] Strip trailing whitespace.

nmap <leader>ss :call StripTrailingWhitespaces()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,t ] Toggle NERDTree.

map <leader>t :NERDTreeToggle<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ti] Toggle indent.

nmap <leader>ti <Plug>IndentGuidesToggle

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,tl] Toggle show limits.

nmap <leader>tl :call ToggleLimits()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ts] Toggle Syntastic.

nmap <leader>ts :SyntasticToggleMode \| w<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,v ] Make the opening of the `.vimrc` file easier.

nmap <leader>v :vsp $MYVIMRC<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,W ] Sudo write.

map <leader>W :w !sudo tee %<CR>


" ----------------------------------------------------------------------
" | Status Line                                                        |
" ----------------------------------------------------------------------

" Terminal types:
"
"   1) term  (normal terminals, e.g.: vt100, xterm)
"   2) cterm (color terminals, e.g.: MS-DOS console, color-xterm)
"   3) gui   (GUIs)

highlight ColorColumn
    \ term=NONE
    \ cterm=NONE  ctermbg=237    ctermfg=NONE
    \ gui=NONE    guibg=#073642  guifg=NONE

highlight CursorLine
    \ term=NONE
    \ cterm=NONE  ctermbg=235  ctermfg=NONE
    \ gui=NONE    guibg=#073642  guifg=NONE

highlight CursorLineNr
    \ term=bold
    \ cterm=bold  ctermbg=NONE   ctermfg=178
    \ gui=bold    guibg=#073642  guifg=Orange

highlight LineNr
    \ term=NONE
    \ cterm=NONE  ctermfg=241    ctermbg=NONE
    \ gui=NONE    guifg=#839497  guibg=#073642

highlight User1
    \ term=NONE
    \ cterm=NONE  ctermbg=237    ctermfg=Grey
    \ gui=NONE    guibg=#073642  guifg=#839496

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set statusline=
set statusline+=%1*            " User1 highlight
set statusline+=\ [%n]         " Buffer number
set statusline+=\ %{GetGitBranchName()}        " Git branch name
set statusline+=\ [%f]         " File path
set statusline+=%m             " Modified flag
set statusline+=%r             " Readonly flag
set statusline+=%h             " Help file flag
set statusline+=%w             " Preview window flag
set statusline+=%y             " File type
set statusline+=[
set statusline+=%{&ff}         " File format
set statusline+=:
set statusline+=%{strlen(&fenc)?&fenc:'none'}  " File encoding
set statusline+=]
set statusline+=%=             " Left/Right separator
set statusline+=%c             " File encoding
set statusline+=,
set statusline+=%l             " Current line number
set statusline+=/
set statusline+=%L             " Total number of lines
set statusline+=\ (%P)\        " Percent through file

" Example result:
"
"  [1] [master] [vim/vimrc][vim][unix:utf-8]            17,238/381 (59%)


" ----------------------------------------------------------------------
" | Local Settings                                                     |
" ----------------------------------------------------------------------

" Load local settings if they exist.
"
" [!] The following needs to remain at the end of this file in
"     order to allow any of the above settings to be overwritten
"     by the local ones.

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
