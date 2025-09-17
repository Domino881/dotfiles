return {
    "nvim-lua/plenary.nvim", -- utilities used by other plugins
    { "numToStr/Comment.nvim", config = true }, -- commenting of lines
    "romainl/vim-cool", -- auto :nohl
    "farmergreg/vim-lastplace", -- opens files at the last place
    "tpope/vim-surround", -- bracket / quote vim motions
    "stevearc/dressing.nvim", -- improved neovim ui
    {
        "stevearc/stickybuf.nvim", -- don't open files in quickfix windows
        config = true,
    },
    "LunarVim/bigfile.nvim", -- disable features in big files
}
