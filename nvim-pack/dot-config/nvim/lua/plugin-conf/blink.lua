require("blink.cmp").setup({
	keymap = {
		-- preset = "default",
		["<C-space>"] = {
			"show",
			"show_documentation",
			"hide_documentation",
		},
		["<C-y>"] = { "select_and_accept" },

		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},
	signature = { enabled = true },

	appearance = {
		-- use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = false },
		-- 'prefix' will fuzzy match on the text before the cursor
		-- 'full' will fuzzy match on the text before _and_ after the cursor
		keyword = { range = "full" },
		menu = {
			auto_show = function(ctx, item)
				if vim.bo.filetype == "markdown" or vim.bo.filetype == "typst" then
					return false
				end
				return true
			end,
			border = "padded",
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
			},
		},
		ghost_text = { enabled = false },
	},

    snippets = { preset = 'luasnip' },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
