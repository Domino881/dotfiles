return {
   "nvim-treesitter/nvim-treesitter",
   enabled = true,
   version = false, -- last release is way too old and doesn't work on Windows
   build = ":TSUpdate",
   event = "VeryLazy",
   keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
   },
   main = "nvim-treesitter.configs",
   opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
         "bash",
         "c",
         "diff",
         "json",
         "lua",
         "luadoc",
         "luap",
         "markdown",
         "markdown_inline",
         "printf",
         "python",
         "regex",
         "toml",
         "vim",
         "vimdoc",
         "xml",
         "yaml",
         "python",
         "cpp",
      },
      incremental_selection = {
         enable = true,
         keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
         },
      },
      textobjects = {
         select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
               ["af"] = "@function.outer",
               ["if"] = "@function.inner",
            },
            selection_modes = {
               ['@parameter.outer'] = 'v', -- charwise
               ['@function.outer'] = 'V', -- linewise
               ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = false,
         },
      },
   },
}
