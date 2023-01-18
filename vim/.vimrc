"=================================================================
"                             vimrc                              "
"=================================================================
"=================================================================
"  Revision  0102
"  Modified  Sunday, 09 October 2022
"=================================================================
set exrc                                " if vimrc in local folder execute it
set encoding=utf-8                      " The encoding displayed
scriptencoding utf-8
setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldcolumn=1
setlocal keywordprg=:help
set nocompatible                        " be iMproved, required
filetype off                            " required


"=================================================================
"Set the Leader Key {
"=================================================================
let g:mapleader = "\<Space>"            " set leader key
"} ===

"=================================================================
" Behavior
"=================================================================
set noswapfile                          " Do not keep swap files
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set shortmess+=filmnrxoOtT     " Abbrev. of messages (avoids 'hit enter')
set formatoptions+=tcq         " Basic formatting of text and comments
set wildmode=list:longest,full " Command <Tab> completion, list matches and
"  complete the longest common part, then,
"  cycle through the matches
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set backspace=2                       " Set backspace
" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> <Esc>:nohl<CR>
inoremap <C-n> <Esc>:nohl<CR>i

"=================================================================
" Vim Editing and Behavior {
"=================================================================
syntax enable                           " Enables syntax highlighing

set clipboard=unnamedplus               " Copy paste between vim and everything else
set modeline                            " Files can use modeline(s)
set modelines=10                        " Check top and bottom 10 lines for modelines(s)
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set belloff=all                         " Disable sound
set visualbell                          " Don't beep, flash the screen instead
set pumheight=10                        " Makes popup menu smaller
set cmdheight=2                         " More space for displaying messages
set laststatus=0                        " Always display the status line
set undodir=~/.vim/undodir              " For undoing history
set undofile
"} ===

"=================================================================
" Vertical indenting {
"=================================================================
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4 softtabstop=4             " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
"} ===

"=================================================================
" Vim Indent and Programming Options {
"=================================================================
set autoindent                 " Keep indent level on new line
set nosmartindent              " Intelligent indenting for source code
set cindent                    " Intelligent indenting for source code
set cinkeys=0{,0},!^F,o,O,e    " default is: 0{,0},0),:,0#,!^F,o,O,e
set showmatch                  " Show matching brackets / parenthesis
set matchtime=5                " Show matching character for .3s
"} ===

"=================================================================
" Vim Search Options {
"=================================================================
set ignorecase             " Ignore case in search patterns
set infercase              " Don't ignore case in auto completion
                           "  but do Ignore it in search patterns
set smartcase              " Don't ignore case if pattern contains it
set incsearch              " Show the 'best match so far'
set wrapscan               " Search will wrap around the file
set hlsearch               " Highlight all matches
"} ===


"=================================================================
" Vim Look and Decorations {
"=================================================================
set ruler              			        " Show the cursor position all the time
set number                              " Line numbers
set relativenumber                      " Set relative line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set noerrorbells
"set nohlsearch                          " Do not keep the search highlighted
"set autochdir                           " Your working directory will always be the same as your working directory
set scrolloff=8                         " Scrol when there are 8 lines left
set colorcolumn=120                      " Visual aid for column 80
set signcolumn=yes                      " Add extra column for diagnostic
"} ===

"=================================================================
" Shift-K Help support {
"=================================================================
" Use <Shift-K> to lookup help for word under the cursor
augroup shift-K
    autocmd!
    autocmd FileType cpp set keywordprg=cppman
    autocmd FileType c set keywordprg=man\ -S3
augroup END
"} ===


au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC


"=================================================================
"= #### Vundle Initialize #### { 
"=================================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"} ===


"=================================================================
" NerdTree to see files in tree mode {
"=================================================================
Plugin 'john-warnes/jvim'
let g:JV_showEol=1       " Show EOL marker
let g:JV_codePretty = 1  " Show indent guides when
"} ===


"=================================================================
" NerdTree [Ctrl-B] {
"=================================================================
Plugin 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plugin 'ryanoasis/vim-devicons'
" Toggle
"nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen    =0          " close NERDTree after  file is opened
let g:NERDTreeShowHidden    =1          " show hidden files in NERDTree
let g:NERDTreeWinSize       =20
let g:NERDTreeMapOpenInTab  ='<TAB>'  " Open file in newtab
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeIndicatorMapCustom = {
            \ 'Modified'  : '✹',
            \ 'Staged'    : '✚',
            \ 'Untracked' : '✭',
            \ 'Renamed'   : '➜',
            \ 'Unmerged'  : '═',
            \ 'Deleted'   : '✖',
            \ 'Dirty'     : '✗',
            \ 'Clean'     : '✔︎',
            \ 'Ignored'   : '☒',
            \ 'Unknown'   : '?'
            \ }

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"} ===

"=================================================================
" Font Icons
"=================================================================
"
Plugin 'ryanoasis/vim-devicons'
"} ===

"=================================================================
" Better Syntax Support
"=================================================================
"
Plugin 'sheerun/vim-polyglot'
"} ===

"=================================================================
" Auto Pairs for '(', '[' '{'
"=================================================================
"
Plugin 'jiangmiao/auto-pairs'
"} ===

"=================================================================
" Language Support
"=================================================================
"
Plugin 'WolfgangMehner/bash-support'
let g:Bash_MapLeader  = ' '
"} ===



"=================================================================
" COC Setup: Needs Vim 8.02 or higher
"=================================================================

"
Plugin 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
let g:coc_global_extensions = ['coc-emmet', 'coc-rust-analyzer', 'coc-clangd', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']
"} ===

"=================================================================
" Color Scheme {
"=================================================================
Plugin 'morhetz/gruvbox'
" <F5> to switch from dark to light
" <F6> to cycle the 3 levels of contrast
nnoremap <silent> <F5> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap <silent> <F6> :call GruvCycleContrast()<CR>
function! GruvCycleContrast()
    if &background ==? 'dark'
        if g:gruvbox_contrast_dark ==? 'soft'
            let g:gruvbox_contrast_dark='medium'
        elseif g:gruvbox_contrast_dark ==? 'medium'
            let g:gruvbox_contrast_dark='hard'
        elseif g:gruvbox_contrast_dark ==? 'hard'
            let g:gruvbox_contrast_dark='soft'
        endif
    else
        if g:gruvbox_contrast_light ==? 'soft'
            let g:gruvbox_contrast_light='medium'
        elseif g:gruvbox_contrast_light ==? 'medium'
            let g:gruvbox_contrast_light='hard'
        elseif g:gruvbox_contrast_light ==? 'hard'
            let g:gruvbox_contrast_light='soft'
        endif
    endif
    colorscheme gruvbox
endfunction

set background=dark            " Start with dark background theme
silent! colorscheme2yy gruvbox    " Color scheme supports truecolor
colorscheme default           " this is the default vim scheme
"} ===


"=================================================================
"=####################= END Plugin System =######################=
"=================================================================
call vundle#end()
filetype plugin indent on

set synmaxcol=1000      " Only syntax hightlight 1000 columns right


"=================================================================
" Color Scheme
"=================================================================
if has('gui_running')
    set background=light
else
    set background=dark
endif

silent! colorscheme gruvbox " colorscheme support truecolor


"=================================================================
" Key Mapping
"=================================================================
" You can't stop me
cmap w!! w !sudo tee %
" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
" use ctr:+hjkl to move between split/vsplit panels
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" Tabs Navigation
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>

" Copy and paste
"set clipboard=unnamed
if has('clipboard') && !has('gui_running')
    vnoremap <C-y> "+y
    vnoremap <C-d> "+d
    vnoremap <C-p> "+p
    inoremap <C-v> <C-r><C-o>+
endif



if (has("termguicolors"))
    set termguicolors
endif
