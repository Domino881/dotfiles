-- Build hooks
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		-- Run build script after plugin's code has changed
		if kind == "install" or kind == "update" then
			if name == "telescope-fzf-native.nvim" then
				vim.system({ "make" }, { cwd = ev.data.path })
			elseif name == "treesitter" then
				vim.cmd(":TSUpdate<CR>")
			elseif name == "LuaSnip" then
				vim.cmd("make install_jsregexp")
			end
		end
	end,
})

-- Colorscheme (gruvbox)
vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
require("plugin-conf.gruvbox")

-- File navigation, pickers (Telescope)
vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
})
require("plugin-conf.telescope")

-- LSP
vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },
	"https://github.com/L3MON4D3/LuaSnip",
})

require("plugin-conf.lsp")
require("plugin-conf.blink")
require("plugin-conf.luasnip")

vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
})
require("plugin-conf.lualine")

-- Quality of life
vim.pack.add({
	"https://github.com/romainl/vim-cool", -- auto :nohl
	"https://github.com/farmergreg/vim-lastplace", -- opens files at the last place
	"https://github.com/stevearc/dressing.nvim", -- improved neovim ui
	"https://github.com/stevearc/stickybuf.nvim", -- don't open files in quickfix windows
	"https://github.com/LunarVim/bigfile.nvim", -- disable features in big files
	"https://github.com/rcarriga/nvim-notify",
})
require("stickybuf").setup()
require("notify").setup({
	render = "minimal",
	top_down = true,
	minimum_width = 30,
	stages = "static",
	background_colour = "#222222",
	merge_duplicates = true,
})
vim.notify = require("notify")

vim.pack.add({
	"https://github.com/uga-rosa/ccc.nvim",
})
require("ccc").setup({})

vim.pack.add({
	"https://github.com/nvim-mini/mini.surround", -- bracket / quote vim motions
})
require("mini.surround").setup({
	mappings = {
		add = "S", -- Add surrounding in Normal and Visual modes
		delete = "ds", -- Delete surrounding
		replace = "cs", -- Replace surrounding
		find = "", -- Find surrounding (to the right)
		find_left = "", -- Find surrounding (to the left)
		highlight = "", -- Highlight surrounding
	},
})

-- Git-related
vim.pack.add({
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/rbong/vim-flog",
	"https://github.com/lewis6991/gitsigns.nvim",
})
require("plugin-conf.fugitive")
require("plugin-conf.gitsigns")

-- Writing previews
vim.pack.add({
	"https://github.com/OXY2DEV/markview.nvim",
	"https://github.com/chomosuke/typst-preview.nvim",
	-- "https://github.com/qwjyh/tinymist-clientfeatures.nvim",
	-- "https://github.com/PartyWumpus/typst-concealer",
})
require("plugin-conf.markview")
-- require("typst-concealer").setup({})
require("typst-preview").setup({
	debug = true,
	extra_args = { "--partial-rendering=true" },
	open_cmd = "qutebrowser %s --qt-wrapper PyQt6 -l critical",
})

vim.pack.add({
	"https://github.com/mikavilpas/yazi.nvim",
})
require("plugin-conf.yazi")

vim.pack.add({
	"https://github.com/kevinhwang91/promise-async",
	"https://github.com/kevinhwang91/nvim-ufo",
})

require("ufo").setup({
	provider_selector = function(_, _, _)
		return { "treesitter", "indent" }
	end,
})

vim.pack.add({
	"https://github.com/altermo/ultimate-autopair.nvim",
})
require("ultimate-autopair").setup({
	cmap = false,
	{ "$", "$", ft = { "tex", "md", "typst" }, space = true, newline = true, fly = true },
	{ "\\[", "\\]", ft = { "tex" } },
	extensions = {
		bigfile = { row_limit = 2000 },
	},
})

vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "Toggle Undotree" })
-- vim.cmd("packadd termdebug")
-- vim.cmd("packadd spellfile")

vim.pack.add({
	"https://github.com/lervag/vimtex",
})
require("plugin-conf.vimtex")

vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})
require("plugin-conf.which-key")

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})
require("plugin-conf.treesitter")

require("plugin-conf.my-floating")
