vim.cmd("source $VIM/vimfiles/arista.vim")

require("options")
require("mappings")
require("lazy-config") -- has to be after mappings
--require('plugins')

require("ibl").setup({ scope = { show_end = false } })
--require('cscope_maps').setup()

require("lualine").setup({
	sections = { lualine_b = {}, lualine_x = { "filetype" } },
})

vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 50

--require("cscope_maps").setup()

vim.cmd("autocmd BufReadPost source ~/.config/nvim/lua/plugins/arista/lib.vim")
vim.cmd("autocmd BufReadPost source ~/.config/nvim/lua/plugins/arista/a4gid.vim")

local wk = require("which-key")
wk.register({ s = {
   a = { "[S]earch [A]4 gid" },
   A = { "[S]earch [A]4 gid (verbose)" },
} }, { prefix = "<leader>" })

require("conform").setup()
--require("conform").formatters.ruff_format = {
   --command = "/home/dkuczynski/.local/share/nvim/mason/bin/ruff",
   --args = { "format", "$FILENAME", "--config", 'indent-width=3'},
--}

-- Default options:
require("gruvbox").setup({
   terminal_colors = true, -- add neovim terminal colors
   undercurl = true,
   underline = true,
   bold = true,
   italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
   },
   strikethrough = true,
   invert_selection = false,
   invert_signs = false,
   invert_tabline = false,
   invert_intend_guides = false,
   inverse = true, -- invert background for search, diffs, statuslines and errors
   contrast = "hard", -- can be "hard", "soft" or empty string
   palette_overrides = {},
   overrides = {
      ColorColumn = {bg = "#151515"},
      SignColumn = {bg = "#1d2021"}
   },
   dim_inactive = false,
   transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
vim.cmd.highlight({ "DiffAdd", "gui=NONE guibg=NONE" })
vim.cmd.highlight({ "DiffDelete", "gui=NONE guibg=NONE" })
vim.cmd.highlight({ "DiffChange", "gui=NONE guibg=NONE" })
