vim.cmd('source $VIM/vimfiles/arista.vim')

require('options')
require('mappings')
require('lazy-config') -- has to be after mappings
--require('plugins')

require('ibl').setup({scope = { show_end = false } })
--require('cscope_maps').setup()

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'
vim.g.gruvbox_italic = 1

vim.cmd('silent! colo gruvbox')
vim.cmd.highlight({ "ColorColumn", "guibg=#151515" })
vim.cmd.highlight({ "DiffAdd", "gui=NONE guibg=NONE" })
vim.cmd.highlight({ "DiffDelete", "gui=NONE guibg=NONE" })
vim.cmd.highlight({ "DiffChange", "gui=NONE guibg=NONE" })

require('lualine').setup{
   sections = { lualine_b = {  }, lualine_x = { 'filetype' } }
}

vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 50

--require("cscope_maps").setup()

vim.cmd("source ~/.config/nvim/lua/plugins/arista/lib.vim")
vim.cmd("source ~/.config/nvim/lua/plugins/arista/a4gid.vim")
