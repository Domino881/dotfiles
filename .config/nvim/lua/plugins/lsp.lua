return { -- LSP Configuration & Plugins
   'neovim/nvim-lspconfig',
   dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
         'j-hui/fidget.nvim',
         opts = {
            progress = {
               poll_rate = 5,
               suppress_on_insert = true,   -- Suppress new messages while in insert mode
               ignore_done_already = true,  -- Ignore new tasks that are already complete
               ignore_empty_message = false, -- Ignore new tasks that don't contain a message
               display = {
                  render_limit = 1,
                  done_ttl = 0.8,
                  format_message = function(msg)
                     if string.find(msg.title, "Indexing") then
                        return nil -- Ignore "Indexing..." progress messages
                     end
                     if msg.message then
                        return msg.message
                     else
                        return msg.done and "✔" or "..."
                     end
                  end
               }
            },
         }
      },
      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
   },
   config = function()
      require('mason').setup()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require("mason-lspconfig").setup {
         ensure_installed = {
            "lua_ls",
            "pylsp",
            -- "pyright",
            "clangd",
         },
         handlers = {
            function(server_name)
               local server = {}
               server.capabilities = capabilities
               require('lspconfig')[server_name].setup(server)
            end,

            ["pyright"] = function()
               require("lspconfig")["pyright"].setup({
                  settings = {
                     python = { analysis = { autoSearchPaths = false } },
                  },
               })
            end,

            ["pylsp"] = function()
               require("lspconfig")["pylsp"].setup({
                  capabilities = capabilities,
                  settings = { pylsp = { plugins = {
                     mccabe = { enabled = true },
                     pycodestyle = {
                        maxLineLength = 80,
                        indentSize = 4,
                        hangClosing = true,
                        ignore = {
                           'E201', 'E202',  -- whitespace around ()
                           'E203', -- space before :
                           'E402', -- import not at the top
                           'E261', -- two spaces before comment
                           'E302', 'E305', 'E306', -- two spaces before functions
                           'E265', -- block comment should start with #
                           'E133', -- closing bracket indent
                           'W504', -- line break after binary operator
                        },
                     }
                  }}}
               })
            end,
         },
      }
      vim.api.nvim_create_autocmd('LspDetach', {
         group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
         callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
         end,
      })
   end,
}
