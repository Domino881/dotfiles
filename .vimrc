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

"""""""""""""""""Plugins"""""""""""""""""
call plug#begin()

" List your plugins here
source ~/.vim/plugins.vim

call plug#end()
"""""""""""""""""Plugins"""""""""""""""""
" -------------- mappings ---------------
imap <C-e> <C-o><C-e>
imap <C-y> <C-o><C-y>
"  window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>

nnoremap <silent> <C-d> Lzz
nnoremap <silent> <C-u> Hzz

" leader mappings
let mapleader = " "
nnoremap <Leader>o o<Esc>0"_Dk
nnoremap <Leader>O O<Esc>0"_Dj

" -------------- plugin options ---------------

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_italic = 0
colorscheme gruvbox

highlight ColorColumn ctermbg=233 guibg=#111111
highlight ColorColumn guibg=#111111
hi DiffAdd cterm=NONE guibg=NONE
hi DiffDelete cterm=NONE guibg=NONE
hi DiffChange cterm=NONE guibg=NONE
"hi Comment cterm=bold

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'background': 'dark',
      \ }

let g:copy_mode = 0
function Copy_mode_toggle()
   if !g:copy_mode 
      set nolist
      set nonumber
      set norelativenumber
      set signcolumn=no
      IndentLinesDisable
      let g:copy_mode = 1
   else
      set list
      set number
      set relativenumber
      set signcolumn=yes
      IndentLinesEnable
      let g:copy_mode = 0
   endif
endfunction
