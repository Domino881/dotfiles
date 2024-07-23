if vim.fn.filereadable("$VIM/vimfiles/arista.vim") then
   vim.cmd("source $VIM/vimfiles/arista.vim")
end

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

vim.cmd("source ~/.config/nvim/lua/plugins/arista/lib.vim")
vim.cmd("source ~/.config/nvim/lua/plugins/arista/a4gid.vim")

local wk = require("which-key")
wk.add {
   { "<leader>sA", desc = "[S]earch [A]4 gid (verbose)" },
   { "<leader>sa", desc = "[S]earch [A]4 gid" },
}

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

local npairs = require'nvim-autopairs'
local Rule = require'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
   -- Rule for a pair with left-side ' ' and right side ' '
   Rule(' ', ' ')
      -- Pair will only occur if the conditional function returns true
      :with_pair(function(opts)
         -- We are checking if we are inserting a space in (), [], or {}
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
      -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
      Rule(bracket[1] .. ' ', ' ' .. bracket[2])
        :with_pair(cond.none())
        :with_move(function(opts) return opts.char == bracket[2] end)
        :with_del(cond.none())
        :use_key(bracket[2])
        -- Removes the trailing whitespace that can occur without this
        :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
   }
end

vim.api.nvim_create_autocmd({ "FileType" }, {
   group = vim.api.nvim_create_augroup('config', { clear = true }),
   pattern = "python",
   callback = function()
      vim.lsp.start({
         name = "ar-pylint-ls",
         cmd = { "ar-pylint-ls" },
         root_dir = "/src",
         settings = { debug = false },
      })
   end,
})

vim.api.nvim_create_autocmd( { 'BufNewFile', 'BufReadPost' },
   { group = 'config',
     pattern = '/src/**',
     callback = function()
        vim.lsp.start( {
           name = 'ar-formatdiff-ls',
           cmd = { 'ar-formatdiff-ls' },
           root_dir = '/src',
           settings = { debug = false },
        } )
     end, } )

vim.keymap.set( 'n', '<leader>lf', function()
   vim.lsp.buf.format( { timeout_ms=5000 } ) end )

require('gitsigns').setup()
