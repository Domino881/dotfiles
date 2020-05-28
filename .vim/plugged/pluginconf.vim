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

let g:goyo_width = 120
let g:goyo_height = "100%"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up']
let g:ycm_key_list_stop_completion = ['<Enter>']
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_enable_diagnostic_highlighting = 0

let g:CoolTotalMatches = 1

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary ctermfg=lightblue cterm=underline
highlight QuickScopeSecondary ctermfg=darkblue cterm=underline
let g:qs_max_chars=80
let g:qs_buftype_blacklist = ['terminal', 'nofile']

let g:mkdp_auto_start = 1

let g:pymode_python = 'python3'
let g:pymode_lint = 0
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
autocmd User GoyoLeave source ~/.vimrc | call lightline#colorscheme()
nnoremap <Leader>G :Goyo <CR>

nnoremap <Leader>N :Note <C-d>
let g:NERDCreateDefaultMappings=0
map <Leader>cc <plug>NERDCommenterToggle
"********************END PLUGIN MAPPINGS********************
