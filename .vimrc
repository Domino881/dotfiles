 "Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

"---------- options ------------

set nocompatible              " be iMproved, required
filetype off                  " required

set number
set relativenumber

set noundofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

set t_Co=256
set laststatus=2
set noshowmode

set background=dark

set tabstop=3
set shiftwidth=3
set expandtab

set nowrap
" indents
set cino=p2s,(0,:1,g1,h2

" color column
set cc=80
set signcolumn=yes

" autocompletion based only on current buffer
set complete=.

set list
set listchars=space:·

" Inspect $TERM instad of t_Co as it works in neovim as well
if &term =~ '256color'
   "   Enable true (24-bit) colors instead of (8-bit) 256 colors.
   "   :h true-color
   if has('termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
   endif
endif
set t_ut=

set mouse=n

"  window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
