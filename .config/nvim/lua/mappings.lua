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
vim.keymap.set("n", "<Leader>o", [[o<Esc>0\"_Dk]], { desc = "Add empty line below" })
vim.keymap.set("n", "<Leader>O", [[O<Esc>0"_Dj]], { desc = "Add empty line above" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open [U]ndotree" })

vim.keymap.set("n", "<leader>sa", vim.cmd.AGid, { desc = "[S]earch [A]Gid" })
vim.keymap.set("n", "<leader>sA", vim.cmd.AGidVerbose, { desc = "[S]earch [A]Gid Verbose" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show [D]iagnostic under cursor" })

vim.api.nvim_create_autocmd ('LspAttach', {
   group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
   callback = function(event)
      local map = function(keys, func, desc)
         vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
   end,
})

-- Git signs Navigation
vim.keymap.set('n', ']c', function()
   if vim.wo.diff then
      vim.cmd.normal({']c', bang = true})
   else
      require"gitsigns".nav_hunk('next')
   end
end, {desc = "Next Git Hunk"})

vim.keymap.set('n', '[c', function()
   if vim.wo.diff then
      vim.cmd.normal({'[c', bang = true})
   else
      require"gitsigns".nav_hunk('prev')
   end
end, {desc = "Previous Git Hunk"})
