--  window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")

vim.keymap.set("v", "p", [["_dP]])

vim.keymap.set("n", "t", "gt")
vim.keymap.set("n", "T", "gT")

-- leader mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>o", [[o<Esc>0\"_Dk]], { desc = "Add empty line below" })
vim.keymap.set("n", "<Leader>O", [[O<Esc>0"_Dj]], { desc = "Add empty line above" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open [U]ndotree" })

vim.keymap.set("n", "<leader>sa", vim.cmd.AGid, { desc = "[S]earch [A]Gid" })
vim.keymap.set("n", "<leader>sA", vim.cmd.AGidVerbose, { desc = "[S]earch [A]Gid Verbose" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show [D]iagnostic under cursor" })

------------- LSP Mappings
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

------------- Git signs Navigation
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

------------- Telescope mappings
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
   })
end, { desc = 'Fuzzily search in current buffer' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
   builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
