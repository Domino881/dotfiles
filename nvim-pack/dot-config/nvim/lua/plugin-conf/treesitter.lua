require("treesitter-context").setup({
	max_lines = "10%",
})
vim.cmd([[hi link TreesitterContext StatusLineNC]])
vim.cmd([[hi link TreesitterContextLineNumber StatusLineNC]])
vim.cmd([[hi TreesitterContextBottom gui=underline guisp=#888888]])

require("nvim-treesitter").install({
	"bash",
	"c",
	"cpp",
	"diff",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"vim",
	"vimdoc",
})
