" Maintainer:	Dominik Kuczyński <GitHub: Domino881>
" Last Change:	2020 May 24

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "kuczy2"

let s:Kdarkdenim='060'
let s:Kaqua='037'
let s:Kyellow='222'
let s:Klorange='216'
let s:Korange='210'

hi normal ctermbg=235

hi  comment ctermfg=darkgrey cterm=italic 

execute 'hi  constant ctermfg=' . s:Kdarkdenim
execute 'hi  string cterm=NONE ctermfg=177' . s:Korange
execute 'hi  character ctermfg=' . s:Korange

execute 'hi  identifier cterm=NONE ctermfg=' . s:Kyellow
execute 'hi  statement guifg=#FF0000 ctermfg=' . s:Klorange
execute 'hi  preproc ctermfg=' . s:Kdarkdenim
execute 'hi  type cterm=bold ctermfg=' . s:Kaqua
execute 'hi  special cterm=bold ctermfg=' . s:Korange

hi  LineNr ctermfg=darkgrey
hi  CursorLineNr ctermfg=grey
hi  SpecialKey ctermfg=237
hi  SignColumn ctermbg=NONE

hi  Search ctermfg=223 ctermbg=NONE cterm=underline
hi  IncSearch ctermfg=NONE ctermbg=133 cterm=NONE
hi  Folded ctermbg=NONE

hi  Visual ctermbg=darkgrey cterm=bold
