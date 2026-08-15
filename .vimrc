set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax on

set number
set relativenumber

set cursorline
set cursorcolumn

set shiftwidth=4
set tabstop=4
set expandtab

set nobackup
set scrolloff=10

set nowrap

set incsearch
set ignorecase
set smartcase

set showcmd
set showmode
set showmatch
set hlsearch
set history=1000

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

colorscheme molokai

" PLUGINS ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')
    Plug 'dense-analysis/ale'
    Plug 'preservim/nerdtree'
call plug#end()
" }}}


" MAPPINGS --------------------------------------------------------------- {{{
let mapleader = '\'

inoremap jj <esc>

nnoremap <leader>\ ``
nnoremap <space> :

nnoremap n nzz
nnoremap N Nzz

nnoremap Y y$

nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

nnoremap <F3> :NERDTreeToggle<cr>

let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
set foldenable
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

if has('gui_running')
    set background=dark
    colorscheme molokai
    set guifont=Monospace\ Regular\ 12
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set guioptions-=b
    nnoremap <F4> :if &guioptions=~'mTr'<Bar>
                \set guioptions-=mTr<Bar>
                \else<Bar>
                \set guioptions+=mTr<Bar>
                \endif<CR>
endif

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

" }}}
