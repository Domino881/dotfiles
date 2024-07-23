vim.cmd("source ~/.config/nvim/lua/plugins/arista/lib.vim")
vim.cmd("source ~/.config/nvim/lua/plugins/arista/a4gid.vim")

vim.api.nvim_create_autocmd({ "FileType" }, {
   group = vim.api.nvim_create_augroup('config', { clear = true }),
   pattern = "python",
   callback = function()
      vim.lsp.start({
         name = "ar-pylint-ls",
         cmd = { "ar-pylint-ls" },
         root_dir = "/src",
         settings = { debug = false },
      })
   end,
})

vim.api.nvim_create_autocmd( { 'BufNewFile', 'BufReadPost' },
   { group = 'config',
     pattern = '/src/**',
     callback = function()
        vim.lsp.start( {
           name = 'ar-formatdiff-ls',
           cmd = { 'ar-formatdiff-ls' },
           root_dir = '/src',
           settings = { debug = false },
        } )
     end, } )

vim.keymap.set( 'n', '<leader>lf', function()
   vim.lsp.buf.format( { timeout_ms=5000 } ) end )


