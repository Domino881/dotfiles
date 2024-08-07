vim.cmd("source $VIM/vimfiles/arista.vim")
vim.cmd("source ~/.config/nvim/lua/plugins/arista/lib.vim")
vim.cmd("source ~/.config/nvim/lua/plugins/arista/a4gid.vim")

local wk = require("which-key")
wk.add {
   { "<leader>sA", desc = "[S]earch [A]4 gid (verbose)" },
   { "<leader>sa", desc = "[S]earch [A]4 gid" },
}

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
   pattern = {'*.tac'},
   callback = function(ev)
      vim.cmd("set syntax=cpp")
   end
})

if not configs.artaclsp then
   configs.artaclsp = {
      default_config = {
         filetypes = { "tac" },
         name = "tacc",
         cmd = { "/usr/bin/artaclsp" },
         cmd_args = { "-I", "/bld/" },
         root_dir = function(fname)
            return "/src"
         end,
      },
   }
end
if not configs.arpylintls then
   configs.arpylintls = {
      default_config = {
         filetypes = { "python" },
         name = "ar-pylint-ls",
         cmd = { "ar-pylint-ls" },
         root_dir = function(fname)
            return "/src"
         end,
         settings = { debug = false },
      },
   }
end
if not configs.arformatdiffls then
   configs.arformatdiffls = {
      default_config = {
         name = "ar-formatdiff-ls",
         cmd = { "ar-formatdiff-ls" },
         root_dir = function(fname)
            return "/src"
         end,
         settings = { debug = false },
      },
   }
end

lspconfig.arpylintls.setup{}
lspconfig.artaclsp.setup{}
lspconfig.arformatdiffls.setup{}
