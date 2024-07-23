require("options")
require("mappings")
require("lazy-config") -- has to be after mappings
require("arista")
--require('plugins')

vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 50


local wk = require("which-key")
wk.add {
   { "<leader>sA", desc = "[S]earch [A]4 gid (verbose)" },
   { "<leader>sa", desc = "[S]earch [A]4 gid" },
}

require("conform").setup()
require('gitsigns').setup()

-- Default options:
require("gruvbox").setup({
   contrast = "hard", -- can be "hard", "soft" or empty string
   overrides = {
      ColorColumn = {bg = "#151515"},
      SignColumn = {bg = "#1d2021"},
      NonText = {fg = "#413b35"},
   },
})

vim.cmd("colorscheme gruvbox")

require('lualine').setup {
   options = {
      icons_enabled = false,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      sections = {
         lualine_a = {'mode'},
         lualine_b = {'diagnostics'},
         lualine_c = {'filename'},
         lualine_x = {'encoding', 'filetype'},
         lualine_y = {'progress'},
         lualine_z = {'location'}
      },
      inactive_sections = {
         lualine_a = {},
         lualine_b = {},
         lualine_c = {'filename'},
         lualine_x = {'location'},
         lualine_y = {},
         lualine_z = {}
      },
   }
}
