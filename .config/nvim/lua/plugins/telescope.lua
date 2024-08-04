return { -- Fuzzy Finder (files, lsp, etc)
'nvim-telescope/telescope.nvim',
event = 'VimEnter',
branch = '0.1.x',
dependencies = {
   'nvim-lua/plenary.nvim',
   {
   'nvim-telescope/telescope-fzf-native.nvim',
   build = 'make',
   cond = function()
      return vim.fn.executable 'make' == 1
   end,
},
{ 'nvim-telescope/telescope-ui-select.nvim' },

-- Useful for getting pretty icons, but requires a Nerd Font.
{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
       require('telescope').setup {
          defaults = {
             layout_config = {
                vertical = { width = 0.5, }
             },
             mappings = {
                i = {
                   ["<esc>"] = require('telescope.actions').close,
                },
             },
             file_ignore_patterns = {
                "/tmp/nvim.dkuczynski/",
             },
          },
          pickers = {
             find_files = { disable_devicons = true },
             grep_string = {
                theme = "dropdown",
                disable_devicons = true,
             },
             live_grep = {
                theme = "dropdown",
                disable_devicons = true,
             },
             oldfiles = { disable_devicons = true },
             highlights = { theme = "dropdown" },
          },
       }
    end,
 }
