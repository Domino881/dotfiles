-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup the plugin manager
require("lazy").setup({
    defaults = { lazy = true },
    lockfile = vim.fn.stdpath("cache") .. "/lazy-lock.json",

    'nvim-lua/plenary.nvim', -- utilities used by other plugins

    -- Options for these plugins are located in .config/nvim/lua/plugins/
    require 'plugins.gruvbox',            -- colorscheme
    require 'plugins.lualine',            -- bottom status line
    require 'plugins.notify',             -- nice notifications
    require 'plugins.treesitter',         -- for better syntax highlighting etc.
    require 'plugins.telescope',          -- search utility
    require 'plugins.which-key',          -- shows hints for keymaps
    require 'plugins.lsp',                -- errors / linting of code
    require 'plugins.cmp',                -- autocompletion (option 1)
    require 'plugins.blink-cmp',          -- autocompletion (option 2)
    require 'plugins.conform',            -- auto formatting of code
    require 'plugins.alpha',              -- home screen
    require 'plugins.gitsigns',           -- git diff lines in signcolumn
    require 'plugins.harpoon',            -- jumping between project files
    require 'plugins.ufo-fold',           -- nicer looking folds
    require 'plugins.treesitter-context', -- context line for long functions
    require 'plugins.nvim-autopairs',     -- automatic brackets
    require 'plugins.undotree',           -- for viewing undo history
    require 'plugins.luasnip',            -- snippets
    require 'plugins.molten-ipython',     -- jupyter-like python execution
    require 'plugins.image',              -- drawing images inside the terminal
    require 'plugins.vimtex',             -- LaTeX integration
    require 'plugins.overseer',           -- build tasks
    require 'plugins.dap',                -- debug adapter protocol
    require 'plugins.dap-ui',             -- nice ui for DAP
    require 'plugins.render-markdown',    -- markdown rendered inside neovim
    require 'plugins.git',                -- Git integrations
    require 'plugins.texmath',            -- my clone of mdmath.nvim - previews of tex math
    require 'plugins.jupyter-kernel',     -- hover / completions from attached kernel

    -- Plugins below are imported with little/no extra options
    { "let-def/texpresso.vim",
        init = function()
            require('texpresso').texpresso_path =
            vim.fn.expand("$HOME/.local/texpresso/build/texpresso")
        end, },                                      -- instant LaTeX preview
    { 'numToStr/Comment.nvim',
        config = true, },                            -- commenting of lines
    { 'nvim-treesitter/nvim-treesitter-textobjects', -- vim motions for functions/classes
        event = 'VeryLazy' },
    { 'lukas-reineke/indent-blankline.nvim',         -- scope indicators
        main = 'ibl' },
    { 'stevearc/stickybuf.nvim',                     -- don't open files in quickfix windows
        config = true },
    'LunarVim/bigfile.nvim',    -- disable features in big files
    'romainl/vim-cool',         -- auto :nohl
    'farmergreg/vim-lastplace', -- opens files at the last place
    'tpope/vim-surround',       -- bracket / quote vim motions
    'stevearc/dressing.nvim',   -- improved neovim ui
}, {
    rocks = {
        hererocks = true,  -- recommended if you do not have global installation of Lua 5.1.
    }
})
