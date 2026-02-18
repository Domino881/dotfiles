return {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	lazy = false,
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	keys = {
		{ "<c-space>", desc = "Increment Selection" },
		{ "<bs>", desc = "Decrement Selection", mode = "x" },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- vim motions for functions/classes
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				max_lines = "10%",
				-- separator = "🭶",
				on_attach = function()
					vim.cmd([[hi link TreesitterContext lualine_c_normal]])
					vim.cmd([[hi link TreesitterContextLineNumber lualine_transitional_lualine_b_normal_to_lualine_c_normal]])
					vim.cmd([[hi TreesitterContextBottom gui=underline guisp=#666666]])
				end,
			},
		},
	},
	main = "nvim-treesitter.configs",
	opts = {
		highlight = { enable = true },
		indent = { enable = true, disable = { "typst" } },
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"regex",
			"toml",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
			"python",
			"cpp",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		textobjects = {
			move = {
				enable = true,
				goto_next_start = { ["]f"] = "@function.outer" },
				goto_next_end = { ["]F"] = "@function.outer" },
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
			},
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
				},
			},
		},
	},
}
