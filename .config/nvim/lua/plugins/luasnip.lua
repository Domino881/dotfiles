return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "blink.cmp" },
		lazy = true,
		event = "VeryLazy",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			update_events = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		},
		-- init = function()
		-- 	require("luasnip.loaders.from_lua").load({
		-- 		paths = { "~/.config/nvim/snippets/lua/" },
		-- 	})
		-- 	-- require("luasnip.loaders.from_vscode").lazy_load({
		-- 	-- 	paths = { "~/.config/nvim/snippets/vscode/friendly-snippets" },
		-- 	-- })
		-- 	--
		-- 	local ls = require("luasnip")
		-- 	vim.keymap.set({ "i", "s" }, "<C-L>", function()
		-- 		ls.jump(1)
		-- 	end, { silent = true })
		-- 	vim.keymap.set({ "i", "s" }, "<C-J>", function()
		-- 		ls.jump(-1)
		-- 	end, { silent = true })
		-- end,
	},
	-- {
	-- 	"iurimateus/luasnip-latex-snippets.nvim",
	-- 	dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
	-- 	opts = { use_treesitter = true },
	-- },
}
