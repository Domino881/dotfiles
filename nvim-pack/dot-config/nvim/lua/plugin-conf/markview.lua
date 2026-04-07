require("markview").setup({
	markdown = {
		headings = {
			heading_1 = { icon_hl = "@markup.link", icon = "[%d] " },
			heading_2 = { icon_hl = "@markup.link", icon = "[%d.%d] " },
			heading_3 = { icon_hl = "@markup.link", icon = "[%d.%d.%d] " },
		},
	},
	typst = {
		enable = false,
		headings = {
			heading_1 = { style = "simple" },
			heading_2 = { style = "simple" },
			heading_3 = { style = "simple" },
		},
		code_blocks = { enable = false },
		code_spans = { enable = false },
		escapes = { enable = false },
		labels = { enable = true },
		list_items = { enable = true },
		math_blocks = { enable = true },
		math_spans = { enable = true },
		raw_blocks = { enable = true },
		raw_spans = { enable = true },
		reference_links = { enable = false },
		subscripts = { enable = false },
		superscripts = { enable = false },
		symbols = { enable = false },
		terms = { enable = false },
		url_links = { enable = false },
	},
})
