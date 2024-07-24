require("options")
require("mappings")
require("lazy-config") -- has to be after mappings
require("arista")

require("lualine").setup({
	sections = { lualine_b = {}, lualine_x = { "filetype" } },
})
require("conform").setup()
require('gitsigns').setup()

vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 50

-- Default options:
require("gruvbox").setup({
   terminal_colors = true, -- add neovim terminal colors
   undercurl = false,
   underline = false,
   bold = false,
   italic = {
      strings = false,
      emphasis = false,
      comments = false,
      operators = false,
      folds = false,
   },
   strikethrough = false,
   invert_selection = false,
   inverse = true, -- invert background for search, diffs, statuslines and errors
   contrast = "hard", -- can be "hard", "soft" or empty string
   overrides = {
      ColorColumn = {bg = "#151515"},
      SignColumn = {bg = "#1d2021"},
      NonText = {fg = "#413b35"},
   },
})
vim.cmd("colorscheme gruvbox")

vim.diagnostic.config({
   float = { source = true, },
})
