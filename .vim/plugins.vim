call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim' "bottom status line
"Plug 'w0rp/ale' "compile, lint C++
"Plug 'maximbaz/lightline-ale'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'abudden/taghighlight-automirror' "extra highlight (e.g. defines)
Plug 'lervag/vimtex'
Plug 'python-mode/python-mode'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'plasticboy/vim-markdown'
Plug 'yuttie/comfortable-motion.vim' "smooth scrolling
Plug 'junegunn/goyo.vim' "distraction-free writing 
"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-marketplace'
Plug 'SirVer/ultisnips'
Plug 'romainl/vim-cool' "auto :nohl
Plug 'unblevable/quick-scope' "highlight first unique letter for f,t,F,T
Plug 'preservim/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'Domino881/kuczy'
Plug 'jacquesbh/vim-showmarks'
Plug 'dhruvasagar/vim-table-mode'

call plug#end()
