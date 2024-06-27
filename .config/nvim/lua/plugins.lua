local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('scrooloose/nerdtree')
Plug('jiangmiao/auto-pairs')
Plug('tpope/vim-surround')
Plug('jeetsukumaran/vim-markology')
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug('junegunn/fzf.vim')
Plug('yuttie/comfortable-motion.vim') --smooth scrolling
Plug('romainl/vim-cool') --auto :nohl
Plug('preservim/nerdcommenter')
Plug('morhetz/gruvbox')
Plug('jacquesbh/vim-showmarks')
Plug('preservim/tagbar')
Plug('dense-analysis/ale')
Plug('dhananjaylatkar/cscope_maps.nvim')
Plug('nmaiti/fzf_cscope.vim')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('nvim-lualine/lualine.nvim')

vim.call('plug#end')
