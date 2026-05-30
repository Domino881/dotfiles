local function match_parent(node, parent_type)
	while node do
		if node:type() == parent_type then
			return true
		end
		node = node:parent()
	end
	return false
end

local function typst_show_menu()
	local success, node = pcall(vim.treesitter.get_node)
	if success then
		return match_parent(node, "code") or match_parent(node, "ref")
	end
	return false
end

local function latex_show_menu()
	local success, node = pcall(vim.treesitter.get_node)
	local active_nodes = {
		generic_command = true,
		inline_formula = true,
		math_environment = true,
	}
	if success then
		for n, _ in pairs(active_nodes) do
			if match_parent(node, n) then
				return true
			end
		end
	end
	return false
end

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-space>"] = {
			"show",
			"show_documentation",
			"hide_documentation",
		},
		["<C-y>"] = { "show_and_insert", "select_and_accept" },

		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

		["<Tab>"] = false,
	},
	signature = { enabled = true },
	cmdline = {
		keymap = {
			-- recommended, as the default keymap will only show and select the next item
			["<Tab>"] = { "show", "accept" },
		},
	},

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
				if vim.bo.filetype == "markdown" then
					return false
				elseif vim.bo.filetype == "typst" then
					return typst_show_menu()
				elseif vim.bo.filetype == "tex" then
					return latex_show_menu()
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

	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
