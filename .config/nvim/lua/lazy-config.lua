-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
   vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
   'nvim-lua/plenary.nvim',
   require 'plugins.gruvbox',
   require 'plugins.lualine',
   require 'plugins.telescope',
   require 'plugins.which-key',
   require 'plugins.cmp',
   require 'plugins.lsp',
   require 'plugins.alpha',
   require 'plugins.gitsigns',
   require 'plugins.harpoon',
   require 'plugins.treesitter',
   'tpope/vim-surround',
   'romainl/vim-cool', --auto :nohl
   'numToStr/Comment.nvim',
   'lukas-reineke/indent-blankline.nvim',
   'mbbill/undotree',
   'farmergreg/vim-lastplace',
   'tpope/vim-fugitive',
})
