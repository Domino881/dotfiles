--  window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")

-- don't lose copied text on paste
vim.keymap.set("v", "p", [["_dP]])

-- changing tabs
vim.keymap.set("n", "t", "gt")
vim.keymap.set("n", "T", "gT")

-- K and J move text up/down in visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- leader mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>o", [[o<Esc>0\"_Dk]], { desc = "Add empty line below" })
vim.keymap.set("n", "<Leader>O", [[O<Esc>0"_Dj]], { desc = "Add empty line above" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic under cursor" })

vim.keymap.set("n", "-", "<cmd>e %:h<CR>")

vim.keymap.set("i", "<C-t>", "<Nop>")
vim.keymap.set("n", "<C-t>", "<Nop>")

-- enter floating window
vim.keymap.set("n", "<C-i>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative == "win" or config.relative == "cursor" then
      vim.api.nvim_set_current_win(win) -- Move cursor to hover window
      return
    end
  end
end, { noremap = true, silent = true })

