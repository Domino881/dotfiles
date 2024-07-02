vim.cmd('source $VIM/vimfiles/arista.vim')

require('options')
require('mappings')
require('config.lazy') -- has to be after mappings
--require('plugins')

require('ibl').setup({scope = { show_end = false } })
--require('cscope_maps').setup()

vim.g.markology_enable = 0

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'
vim.g.gruvbox_italic = 1

vim.cmd('silent! colo gruvbox')
vim.cmd.highlight({ "ColorColumn", "guibg=#151515" })

require('lualine').setup{
   sections = { lualine_b = {  }, lualine_x = { 'filetype' } }
}

