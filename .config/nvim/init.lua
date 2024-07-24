require("options")
require("mappings")
require("lazy-config") -- has to be after mappings
require("arista")

require("ibl").setup({ scope = { show_end = false } })
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
      SignColumn = {bg = "#1d2021"},
      NonText = {fg = "#413b35"},
   },
   dim_inactive = false,
   transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
vim.cmd.highlight({ "DiffAdd", "gui=NONE guifg=#8ec07c guibg=NONE" })
vim.cmd.highlight({ "DiffDelete", "gui=NONE guifg=#fb4934 guibg=NONE" })
vim.cmd.highlight({ "DiffChange", "gui=NONE guifg=#83a598 guibg=NONE" })

vim.diagnostic.config({
   float = { source = true, },
})

local npairs = require'nvim-autopairs'
local Rule = require'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
   -- Rule for a pair with left-side ' ' and right side ' '
   Rule(' ', ' ')
      :with_pair(function(opts)
         local pair = opts.line:sub(opts.col - 1, opts.col)
         return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2]
         }, pair)
      end)
      :with_move(cond.none())
      :with_cr(cond.none())
      -- We only want to delete the pair of spaces when the cursor is as such: ( | )
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local context = opts.line:sub(col - 1, col + 2)
        return vim.tbl_contains({
           brackets[1][1] .. '  ' .. brackets[1][2],
           brackets[2][1] .. '  ' .. brackets[2][2],
           brackets[3][1] .. '  ' .. brackets[3][2]
        }, context)
      end)
}
-- For each pair of brackets we will add another rule
for _, bracket in pairs(brackets) do
   npairs.add_rules {
      Rule(bracket[1] .. ' ', ' ' .. bracket[2])
        :with_pair(cond.none())
        :with_move(function(opts) return opts.char == bracket[2] end)
        :with_del(cond.none())
        :use_key(bracket[2])
        :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
   }
end
