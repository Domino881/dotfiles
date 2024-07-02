-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
   vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
   'morhetz/gruvbox',
   'nvim-lualine/lualine.nvim',
   require 'plugins.telescope',
   require 'plugins.which-key',
   require 'plugins.cmp',
   require 'plugins.lsp',
   --'scrooloose/nerdtree',
   'jiangmiao/auto-pairs',
   'tpope/vim-surround',
   'romainl/vim-cool', --auto :nohl
   'preservim/nerdcommenter',
   'jacquesbh/vim-showmarks',
   'preservim/tagbar',
   'lukas-reineke/indent-blankline.nvim',
    --automatically check for plugin updates
   --checker = { enabled = true },
})
