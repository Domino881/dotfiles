return {
	"altermo/ultimate-autopair.nvim",
	lazy = true,
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6", --recommended as each new version will have breaking changes
	opts = {
		cmap = false,
		{ "$", "$", ft = { "tex", "md", "typst" }, space = true, newline = true },
		{ "\\[", "\\]", ft = { "tex" } },
	},
}
