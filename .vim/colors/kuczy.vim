" Maintainer:	Dominik Kuczyński <GitHub: Domino881>
" Last Change:	2020 May 24

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "kuczy"
hi  comment ctermfg=darkgrey cterm=italic 

hi  constant ctermfg=147
hi  string ctermfg=177
hi  character ctermfg=098

hi  identifier ctermfg=044 cterm=bold
hi  statement ctermfg=yellow
hi  preproc ctermfg=darkblue 
hi  type ctermfg=079
hi  special ctermfg=111 

hi  LineNr ctermfg=darkgrey
hi  CursorLineNr ctermfg=grey
hi  SpecialKey ctermfg=237
hi  SignColumn ctermbg=NONE

hi  Search ctermfg=NONE ctermbg=darkgrey
hi  IncSearch ctermfg=NONE ctermbg=074
hi  Folded ctermbg=NONE

hi  Visual ctermbg=darkgrey cterm=bold
