set nocompatible              " be iMproved, required
filetype off                  " required
syntax on
set tabstop=2
set shiftwidth=2
set hlsearch
set incsearch
set number relativenumber
let mapleader=" "
let maplocalleader=" "
set scrolloff=4
set nowrap
set splitright
set splitbelow

"********************MISCELLANEOUS********************
command Wq wq
command W w
command Q q

set ttimeoutlen=10
set timeoutlen=400
set laststatus=2
set noshowmode
set background=dark
colorscheme ron

"folding
set foldmethod=syntax
set foldlevel=9999 
highlight Folded ctermbg=NONE
highlight LineNr ctermfg=darkgrey
highlight CursorLineNr ctermfg=grey
highlight Search ctermbg=darkblue
highlight SignColumn ctermbg=black

set pastetoggle=<Leader>p
:command Keywordll syn keyword Type ll

nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
nnoremap <silent><expr> <Leader>m (&mouse == "a" ? ':set mouse=<CR>:echo "mouse off"<CR>' : ':set mouse=a<CR>:echo "mouse on"<CR>')
nnoremap <Leader>n :set nu!<CR>:set rnu!<CR>


nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>e :pclose<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

autocmd Filetype cpp inoremap <Bslash>f for(int i=0;i<n;i++){}<Left>
autocmd Filetype cpp inoremap <Bslash>i if(){}<Left><Left><Left>

nnoremap <Leader>t :bot term ++rows=12<CR>
tnoremap <Leader>t <C-d>

nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

if !isdirectory("/tmp/.vim-undo-dir")
	call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undodir=/tmp/.vim-undo-dir
set undofile
"********************END MISCELLANEOUS********************

"********************MOVEMENT MAPPINGS********************
"alt + hjkl
set termencoding=utf8
set encoding=utf8
inoremap <m-h> <Left>
inoremap <m-j> <Down>
inoremap <m-k> <Up>
inoremap <m-l> <Right>
inoremap <m-o> <C-o>o

"delete whole words
nnoremap <m-x> "_dib
inoremap <m-x> <Esc>"_dibi

"skip words in insert
inoremap <m-w> <C-o>w
inoremap <m-q> <C-o>b
set backspace=indent,eol,start

"alt+<> -> home, end
inoremap <m-,> <C-o>0
inoremap <m-.> <C-o>$

nnoremap <Leader>j 30j
nnoremap <Leader>k 30k

nnoremap <C-h> <C-w><Left>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>
tnoremap <C-h> <C-w><Left>
tnoremap <C-j> <C-w><Down>
tnoremap <C-k> <C-w><Up>
tnoremap <C-l> <C-w><Right>

" nnoremap < <<
" nnoremap > >>

imap <C-e> <C-o><C-e>
imap <C-y> <C-o><C-y>
imap <C-d> <C-o><C-d>
imap <C-u> <C-o><C-u>

vnoremap < <gv
vnoremap > >gv
"********************END MOVEMENT MAPPINGS********************

"********************PYTHON********************
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match SpellBad /\s\+$/
"********************END PYTHON********************

"********************PLUGINS********************

call plug#begin('~/.vim/plugged')

" more Plugin commands
so ~/.vim/plugins.vim

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0

let g:AutoPairsMapBS = 0
let g:AutoPairsMultilineClose = 0

let g:lightline = {
	\ 'colorscheme': 'jellybeans',
	\}
let g:vimtex_view_method = 'zathura'

packadd termdebug
let g:termdebug_wide = 1
hi debugPC ctermbg=darkblue 
function TDBG(file, path)
	let l:pathfile = a:path . "/" . a:file
	let l:pathbinfile = a:path . "/bin/" . a:file
	echo l:pathfile
	if file_readable(l:pathfile)
		execute "Termdebug" . l:pathfile
	elseif file_readable(l:pathbinfile)
		execute "Termdebug" . l:pathbinfile
	elseif file_readable(l:pathfile . ".e")
		execute "Termdebug" . l:pathfile . ".e"
	elseif file_readable(l:pathbinfile . ".e")
		execute "Termdebug" . l:pathbinfile . ".e"
	else
		:echo "executable not found"
	endif
endfunction
autocmd FileType cpp nnoremap <Leader>T :call TDBG(expand('%:t:r'), expand('%:p:h'))<CR>

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
	colorscheme ron
	highlight Folded ctermbg=NONE
	highlight LineNr ctermfg=darkgrey
	highlight CursorLineNr ctermfg=grey
	highlight Search ctermbg=darkblue
	highlight SignColumn ctermbg=black
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction
let g:goyo_width = 120
let g:goyo_height = "100%"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up']
let g:ycm_key_list_stop_completion = ['<Enter>', '<C-y>']
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_enable_diagnostic_highlighting = 0

let g:CoolTotalMatches = 1

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary ctermfg=lightblue cterm=underline
highlight QuickScopeSecondary ctermfg=blue cterm=underline
let g:qs_max_chars=80
let g:qs_buftype_blacklist = ['terminal', 'nofile']

call plug#end()
"********************END PLUGINS********************

""********************PLUGIN MAPPINGS********************
map <F4> :NERDTree <CR>
map <F3> :ALEResetBuffer<CR>
nnoremap <C-t> :Files<CR>
autocmd FileType tex nnoremap <Leader>lv :VimtexView<CR>
autocmd FileType tex nnoremap <Leader>lt :VimtexTocOpen<CR>
autocmd FileType py let g:ale_enabled = 0
autocmd FileType markdown nnoremap <Leader>ll :MarkdownPreview<CR>
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
autocmd FileType cpp noremap ,S :call TermDebugSendCommand('start')<CR>
autocmd FileType cpp noremap ,s :call TermDebugSendCommand('step')<CR>
autocmd FileType cpp noremap ,n :call TermDebugSendCommand('next')<CR>
autocmd FileType cpp noremap ,b :call TermDebugSendCommand('break')<CR>
autocmd FileType cpp noremap ,c :call TermDebugSendCommand('clear')<CR>
autocmd FileType cpp noremap ,f :call TermDebugSendCommand('finish')<CR>

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
nnoremap <Leader>G :Goyo <CR>

nnoremap <Leader>N :Note <C-d>
"********************END PLUGIN MAPPINGS********************
