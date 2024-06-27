vim.keymap.set("i", "<C-e>", "<C-o><C-e>")
vim.keymap.set("i", "<C-y>", "<C-o><C-y>")

--  window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("i", "<C-n>", "<C-R>=SmartInsertCompletion()<CR>")

vim.keymap.set("n", "<C-d>", "<C-e>:sleep 50m <CR>15<C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>:sleep 10m <CR><C-e>", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-y>:sleep 50m <CR>15<C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>:sleep 10m <CR><C-y>", { silent = true })
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>", { silent = true })
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>", { silent = true })

vim.keymap.set("n", "[[ ", ":TagbarJumpPrev<CR>")
vim.keymap.set("n", "]]", ":TagbarJumpNext<CR>")

-- leader mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>o", [[o<Esc>0\"_Dk]])
vim.keymap.set("n", "<Leader>O", [[O<Esc>0"_Dj]])
vim.keymap.set("n", "<Leader>f", ":Files<Return>")
vim.keymap.set("n", "<Leader>r", ":Rg<Return>")
vim.keymap.set("v", "<Leader>r", [["ry:Rg "<C-r>r<Return>]])
vim.keymap.set("n", "<Leader>b", ":Buffers<Return>")

vim.keymap.set("n", "<Leader>t",         ":TagbarToggle<CR>")
vim.keymap.set("n", "<Leader><Leader>k", [[:echo "a: Find assignments to this symbol\nc: Find functions calling this function\nd: Find functions called by this function\ne: Find this egrep pattern\nf: Find this file\ng: Find this definition\ni: Find files #including this file\ns: Find this C symbol\nt: Find this text string\n"<CR>]])
vim.keymap.set("n", "<Leader>n",         ":NERDTreeToggle<CR")

vim.keymap.set("n", "Q", "<nop>")
