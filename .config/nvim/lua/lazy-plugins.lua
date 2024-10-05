-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup the plugin manager
require("lazy").setup{

    'nvim-lua/plenary.nvim',               -- utilities used by other plugins

    -- Options for these plugins are located in .config/nvim/lua/plugins/
    require 'plugins.gruvbox',            -- colorscheme
    require 'plugins.lualine',            -- bottom status line
    require 'plugins.treesitter',         -- for better syntax highlighting etc.
    require 'plugins.telescope',          -- search utility
    require 'plugins.which-key',          -- shows hints for keymaps
    require 'plugins.lsp',                -- errors / linting of code
    require 'plugins.cmp',                -- autocompletion
    require 'plugins.gitsigns',           -- git diff lines in signcolumn
    require 'plugins.ufo-fold',           -- nicer looking folds
    require 'plugins.treesitter-context', -- context line for long functions
    require 'plugins.ult-autopair',       -- automatic brackets

    -- Plugins below are imported with little/no extra options
    {
        'numToStr/Comment.nvim',          -- commenting of lines
        config = true
    },
    {
        'lukas-reineke/indent-blankline.nvim', -- scope indicators
        main = 'ibl', config = true
    },
    'tpope/vim-surround',                 -- bracket / quote vim motions
    'romainl/vim-cool',                   -- auto :nohl
    'farmergreg/vim-lastplace',           -- opens files at the last place
    'tpope/vim-fugitive',                 -- git utilities
}
