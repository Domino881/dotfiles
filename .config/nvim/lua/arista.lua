vim.api.nvim_create_autocmd({"BufFilePost"}, {
   callback = function(ev)
      vim.cmd("source ~/.config/nvim/lua/plugins/arista/lib.vim")
      vim.cmd("source ~/.config/nvim/lua/plugins/arista/a4gid.vim")
   end
})

local wk = require("which-key")
wk.add {
   { "<leader>sA", desc = "[S]earch [A]4 gid (verbose)" },
   { "<leader>sa", desc = "[S]earch [A]4 gid" },
}

vim.filetype.add( {
   extension = {
      tac = 'tac',
      tin = 'tin',
   }
})

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
   pattern = {'*.tac', '*.tin'},
   callback = function(ev)
      vim.cmd("set syntax=cpp")
      local ext = vim.fn.expand("%:e")
      if ext == "tac" then
         vim.keymap.set("n", "<leader>t", function()
            vim.cmd("edit %:r.tin")
         end)
      else
         vim.keymap.set("n", "<leader>t", function()
            vim.cmd("edit %:r.tac")
         end)
      end
   end
})

if not configs.artaclsp then
   configs.artaclsp = {
      default_config = {
         filetypes = { "tac", "tin" },
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
