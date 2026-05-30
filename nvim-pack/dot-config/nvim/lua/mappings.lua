--  window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-;>", "<C-w>p")

-- don't lose copied text on paste
-- vim.keymap.set("v", "p", [["_dP]])
vim.keymap.set("n", "t", "gt")
vim.keymap.set("n", "T", "gT")

-- K and J move text up/down in visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- leader mappings
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic under cursor" })

-- vim.keymap.set("n", "-", "<cmd>e %:h<CR>")

vim.keymap.set("i", "<C-t>", "<Nop>")
vim.keymap.set("n", "<C-t>", "<Nop>")

vim.keymap.set("n", "<F5>", ":OverseerRestartLast<CR>")
vim.keymap.set("n", "<F6>", ":OverseerRun<CR>")
vim.keymap.set("n", "<F7>", ":OverseerToggle<CR>")

vim.keymap.set("n", "<leader>.l", ":luafile %<CR>", { desc = "Source current Lua file" })
vim.keymap.set("n", "<leader>..", ":source %<CR>", { desc = "Source current file" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste to system clipboard" })

vim.keymap.set("c", "<C-j>", "<C-Left>")
vim.keymap.set("c", "<C-k>", "<C-Right>")
vim.keymap.set("c", "<C-a>", "<Home>")

vim.keymap.set("n", "<C-w><CR>", ":85vsp<CR><C-w>w:term<CR>i")
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-;>", "<C-\\><C-n><C-w>p")

vim.keymap.set("n", "z==", "1z=")

vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to next error in the current buffer" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to previous error in the current buffer" })

vim.api.nvim_create_augroup("typst", { clear = true })
vim.api.nvim_create_autocmd({ "Filetype" }, {
	pattern = { "typst" },
	group = "typst",
	callback = function()
		vim.keymap.set("n", "]]", "/^=<CR>:nohl<CR>", { desc = "Next Typst Chapter" })
		vim.keymap.set("n", "[[", "?^=<CR>:nohl<CR>", { desc = "Previous Typst Chapter" })
		vim.keymap.set("v", "]]", "/^=<CR>", { desc = "Next Typst Chapter" })
		vim.keymap.set("v", "[[", "?^=<CR>", { desc = "Previous Typst Chapter" })
		vim.keymap.set("n", "]=", "0/^\\s*=<CR>:nohl<CR>^", { desc = "Next Equality Break" })
		vim.keymap.set("n", "[=", "0?^\\s*=<CR>:nohl<CR>^", { desc = "Previous Equality Break" })
		vim.keymap.set("v", "]=", "0/^\\s*=<CR>", { desc = "Next Equality Break" })
		vim.keymap.set("v", "[=", "0?^\\s*=<CR>", { desc = "Previous Equality Break" })
	end,
})
