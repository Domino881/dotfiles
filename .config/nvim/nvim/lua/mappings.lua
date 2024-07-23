vim.g.mapleader = " "

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")

-- leader mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>sa", vim.cmd.AGid)
vim.keymap.set("n", "<leader>sA", vim.cmd.AGidVerbose)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

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
      --map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      --map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
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
end)

vim.keymap.set('n', '[c', function()
   if vim.wo.diff then
      vim.cmd.normal({'[c', bang = true})
   else
      require"gitsigns".nav_hunk('prev')
   end
end)
