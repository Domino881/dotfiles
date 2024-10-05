-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    'nvim-lua/plenary.nvim',               -- utilities used by other plugins
    require 'plugins.gruvbox',             -- colorscheme
    require 'plugins.lualine',             -- bottom status line
    require 'plugins.treesitter',          -- for better syntax highlighting etc.
    require 'plugins.telescope',           -- search utility
    require 'plugins.which-key',           -- shows hints for keymaps
    require 'plugins.lsp',                 -- errors / linting of code
    require 'plugins.cmp',                 -- autocompletion
    require 'plugins.conform',             -- auto formatting of code
    require 'plugins.alpha',               -- home screen
    require 'plugins.gitsigns',            -- git diff lines in signcolumn
    require 'plugins.harpoon',             -- jumping between project files
    require 'plugins.ufo-fold',            -- nicer looking folds
    require 'plugins.treesitter-context',  -- context line for long functions
    require 'plugins.ult-autopair',        -- automatic brackets
    require 'plugins.undotree',            -- for viewing undo history
    require 'plugins.luasnip',             -- snippets
    require 'plugins.molten-ipython',      -- jupyter-like python execution
    require 'plugins.image',               -- drawing images inside the terminal
    'lervag/vimtex',                       -- LaTeX integration
    { 'numToStr/Comment.nvim',                       config = true }, -- commenting of lines
    { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
    { 'lukas-reineke/indent-blankline.nvim',         main = 'ibl',    config = true }, -- scope indicators
    'tpope/vim-surround',                  -- bracket / quote vim motions
    'romainl/vim-cool',                    -- auto :nohl
    'farmergreg/vim-lastplace',            -- opens files at the last place
    'tpope/vim-fugitive',                  -- git utilities
})
