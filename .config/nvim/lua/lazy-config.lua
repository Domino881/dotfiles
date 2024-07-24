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
   { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
   require 'plugins.lualine',
   require 'plugins.telescope',
   require 'plugins.which-key',
   require 'plugins.cmp',
   require 'plugins.lsp',
   require 'plugins.conform',
   require 'plugins.harpoon',
   require 'plugins.alpha',
   'tpope/vim-surround',
   'romainl/vim-cool', --auto :nohl
   'numToStr/Comment.nvim',
   'farmergreg/vim-lastplace',
   'tpope/vim-fugitive',
   'lewis6991/gitsigns.nvim',
})
