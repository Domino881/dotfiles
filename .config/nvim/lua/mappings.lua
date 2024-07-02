vim.g.mapleader = " "

vim.keymap.set("i", "<C-e>", "<C-o><C-e>")
vim.keymap.set("i", "<C-y>", "<C-o><C-y>")

--  window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")


-- scroll mappings
--vim.keymap.set("n", "<C-d>", "<C-e>:sleep 50m <CR>15<C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>", { silent = true })
--vim.keymap.set("n", "<C-u>", "<C-y>:sleep 50m <CR>15<C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>", { silent = true })
vim.keymap.set("n", "<C-d>", "15jzz")
vim.keymap.set("n", "<C-u>", "15kzz")
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>", { silent = true })
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>", { silent = true })

vim.keymap.set("n", "Q", "<nop>")

-- leader mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>o", [[o<Esc>0\"_Dk]])
vim.keymap.set("n", "<Leader>O", [[O<Esc>0"_Dj]])

vim.keymap.set("n", "<Leader>t",         ":TagbarToggle<CR>")
vim.keymap.set("n", "<Leader><Leader>k", [[:echo "a: Find assignments to this symbol\nc: Find functions calling this function\nd: Find functions called by this function\ne: Find this egrep pattern\nf: Find this file\ng: Find this definition\ni: Find files #including this file\ns: Find this C symbol\nt: Find this text string\n"<CR>]])
vim.keymap.set("n", "<Leader>n",         ":NERDTreeToggle<CR>")

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
