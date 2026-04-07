require("telescope").setup({
	defaults = {
		border = true,
		layout_config = {
			vertical = { width = 0.7 },
			horizontal = { width = 0.9 },
		},
		mappings = {
			i = {
				["<esc>"] = "close",
			},
		},
		file_ignore_patterns = {
			"/tmp/nvim.dkuczynski/",
		},
	},
	pickers = {
		find_files = { disable_devicons = true },
		grep_string = {
			theme = "dropdown",
			disable_devicons = true,
		},
		live_grep = {
			theme = "dropdown",
			disable_devicons = true,
		},
		oldfiles = { disable_devicons = true },
		highlights = { theme = "dropdown" },
	},
	load_extension = {
		"bibtex",
		"luasnip",
	},
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Resume Previous Search" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search Recent Files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
		hidden = false,
	})
end, { desc = "Search Neovim files" })
