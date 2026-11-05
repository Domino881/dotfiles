vim.pack.add({
	"https://github.com/pappasam/nvim-repl.git",
})
require("repl").setup({
	default = { cmd = "zsh", filetype = "zsh" },
	filetype_commands = {
		python = { cmd = "uv run ipython --no-autoindent" },
	},
	open_window_default = "belowright 42 vsp new",
})

vim.keymap.set("n", "<C-w>R", ":Repl<CR>")
vim.keymap.set("n", "<C-8>", "mr:call repl#sendcell()<CR>`r")
vim.keymap.set("x", "<C-8>", "<Plug>(ReplSendVisual)")
