" Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

" Include Arista-specific settings
:if filereadable( $VIM . "/vimfiles/arista.vim" )
   source $VIM/vimfiles/arista.vim
:endif

set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""Plugins"""""""""""""""""
call plug#begin()

" List your plugins here
source ~/.vim/plugins.vim

call plug#end()
"""""""""""""""""Plugins"""""""""""""""""

set number
set relativenumber

set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

if !has('gui_running')
  set t_Co=256
endif
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'background': 'dark',
      \ }
set noshowmode

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
colorscheme gruvbox
set background=dark
"hi MarkologyHLl cterm=bold ctermfg=8
hi MarkologyHLo ctermfg=0

" tabs
set tabstop=3
set shiftwidth=3
set expandtab

set nowrap
" indents
set cino=p2s,(0,:1,g1,h2

" color column
set cc=86
set signcolumn=yes
highlight ColorColumn ctermbg=233

" mappings
imap <C-e> <C-o><C-e>
imap <C-y> <C-o><C-y>


let mapleader = " "
nnoremap <Leader>o o<Esc>0"_Dk
nnoremap <Leader>O O<Esc>0"_Dj

nnoremap <Leader>f :Files<Return>
nnoremap <Leader>r :Rg<Return>
vnoremap <Leader>r "ry:Rg <C-r>r<Return>

"  window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let g:comfortable_motion_friction=500.0
let g:comfortable_motion_air_drag=0.0
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 0.8  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> <C-e>:sleep 50m <CR>15<C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>
nnoremap <silent> <C-u> <C-y>:sleep 50m <CR>15<C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>
noremap <silent> <ScrollWheelDown> <C-e>
noremap <silent> <ScrollWheelUp>   <C-y>
"nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
"nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
"nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
"nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

nnoremap <Leader>t :TagbarToggle<CR>
map [[ :TagbarJumpPrev<CR>
map ]] :TagbarJumpNext<CR>
let g:lightline = {
      \ 'active': {
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'tagbar', 'fileencoding', 'filetype' ] ]
      \            },
      \ 'component': {
      \         'tagbar': '%{Abc("%s", "", "f")}',
      \ }
      \ }
      "\            [ 'tagbar', 'fileencoding', 'filetype' ] ]
let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

function! Abc(c1, c2, c3)
   let g:str =  tagbar#currenttag("%s", "", "f")
   return g:str[-winwidth('%')+65:]
endfunction

let g:ale_cpp_cc_options = '-std=c++20 -Wall'
set complete=.
function! SmartInsertCompletion() abort
 " Use the default CTRL-N in completion menus
 if pumvisible()
   return "\<C-n>"
 endif
 " Exit and re-enter insert mode, and use insert completion
 return "\<C-c>a\<C-n>"
endfunction

inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>

let g:fzf_vim = {}
" [Buffers] Jump to the existing window if possible
let g:fzf_vim.buffers_jump = 1

" [Tags] Command to generate tags file
let g:fzf_vim.tags_command = 'ctags -R'
" --sort --options=/home/dkuczynski/.ctags.conf'

source ~/.vim/cscope_maps.vim
nnoremap <silent> <Leader>cg :call CscopeFZF("g", 0, "<C-R>=expand('<cword>')<CR>")<CR>

let g:indentLine_color_term = 238
let g:indentLine_char = '￨'
set list
set listchars=space:·
