 "Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

 "Include Arista-specific settings
:if filereadable( $VIM . "/vimfiles/arista.vim" )
   source $VIM/vimfiles/arista.vim
:endif

"---------- options ------------

set nocompatible              " be iMproved, required
filetype off                  " required

set number
set relativenumber

set undodir=~/.vim/undodir
set undofile
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
set cc=86
set signcolumn=yes

" autocompletion based only on current buffer
set complete=.

set list
set listchars=space:·

if has("termguicolors")
   set termguicolors
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

nnoremap <silent> <C-d> <C-e>:sleep 50m <CR>15<C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>
nnoremap <silent> <C-u> <C-y>:sleep 50m <CR>15<C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>
noremap <silent> <ScrollWheelDown> <C-e>
noremap <silent> <ScrollWheelUp>   <C-y>

map [[ :TagbarJumpPrev<CR>
map ]] :TagbarJumpNext<CR>

vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

" leader mappings
let mapleader = " "
nnoremap <Leader>o o<Esc>0"_Dk
nnoremap <Leader>O O<Esc>0"_Dj

nnoremap <Leader>f :Files<Return>
nnoremap <Leader>r :Rg<Return>
vnoremap <Leader>r "ry:Rg "<C-r>r<Return>
nnoremap <Leader>b :Buffers<Return>

"let NERDCreateDefaultMappings=0
"nmap <Leader>v <plug>NERDCommenterToggle
"vmap <Leader>v <plug>NERDCommenterToggle

nnoremap <Leader>t :TagbarToggle<CR>

nnoremap <Leader><Leader>k :echo "a: Find assignments to this symbol\nc: Find functions calling this function\nd: Find functions called by this function\ne: Find this egrep pattern\nf: Find this file\ng: Find this definition\ni: Find files #including this file\ns: Find this C symbol\nt: Find this text string\n"<CR>

nnoremap <Leader>n :NERDTreeToggle<CR>

" -------------- plugin options ---------------


let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_italic = 1
colorscheme gruvbox

let g:markology_enable = 0

hi MarkologyHLo ctermfg=0
highlight ColorColumn guibg=#111111
"hi Comment cterm=bold

let g:comfortable_motion_friction=500.0
let g:comfortable_motion_air_drag=0.0
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 0.8  " Feel free to increase/decrease this value.

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'background': 'dark',
      \ }
let g:lightline = {
      \ 'active': {
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'tagbar', 'filetype' ] ]
      \            },
      \ 'component': {
      \         'tagbar': '%{Tagbar_cur_tag()}',
      \ }
      \ }
      "\            [ 'tagbar', 'fileencoding', 'filetype' ] ]
"let g:tagbar_status_func = 'TagbarStatusFunc'
"function! TagbarStatusFunc(current, sort, fname, ...) abort
    "let g:lightline.fname = a:fname
  "return lightline#statusline(0)
"endfunction

function! Tagbar_cur_tag()
   let str =  tagbar#currenttag("%s", "", "f")
   if len(str) > winwidth('%')-65
      let str = "…" .. str[-winwidth('%')+65:]
   endif
   return str
endfunction

let g:ale_cpp_cc_options = '-std=c++20 -Wall'
let g:ale_python_mypy_options = '--disable-error-code import-untyped'
function! SmartInsertCompletion() abort
 " Use the default CTRL-N in completion menus
 if pumvisible()
   return "\<C-n>"
 endif
 " Exit and re-enter insert mode, and use insert completion
 return "\<C-c>a\<C-n>"
endfunction


let g:fzf_vim = {}
" [Buffers] Jump to the existing window if possible
let g:fzf_vim.buffers_jump = 0

" [Tags] Command to generate tags file
let g:fzf_vim.tags_command = 'ctags -R'
" --sort --options=/home/dkuczynski/.ctags.conf'

let g:indentLine_color_term = 238
let g:indentLine_char = '￨'

let g:NERDTreeWinSize = 42
"let g:NERDTreeWinPos = 'right'

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
let g:svndiff_autoupdate = 1
