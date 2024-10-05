-- This is the main configuration file read by neovim.
-- From here, it goes into the different files in the lua/ folder.

require("options")      -- Vim-native options
require("lazy-plugins") -- Plugins, via the Lazy.nvim plugin manager
require("mappings")     -- Non-plugin specific keymaps

vim.cmd("colorscheme gruvbox")
