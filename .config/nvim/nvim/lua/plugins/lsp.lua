return { -- LSP Configuration & Plugins
   'neovim/nvim-lspconfig',
   dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
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
            "pyright",
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
         },
      }
   end,
  }
