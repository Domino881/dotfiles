return { -- Autocompletion
'hrsh7th/nvim-cmp',
event = 'InsertEnter',
dependencies = {
   'hrsh7th/cmp-nvim-lsp',
   'hrsh7th/cmp-path',
},
config = function()
   local cmp = require 'cmp'

   cmp.setup {
      snippet = {
         expand = function(args)
         end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = cmp.mapping.preset.insert {
         ['<C-n>'] = cmp.mapping.select_next_item(),
         ['<C-p>'] = cmp.mapping.select_prev_item(),
         -- Scroll the documentation window [b]ack / [f]orward
         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
         ['<C-f>'] = cmp.mapping.scroll_docs(4),
         ['<C-y>'] = cmp.mapping.confirm { select = true },
         ['<C-Space>'] = cmp.mapping.complete {},

         ['<C-l>'] = cmp.mapping(function()
         end, { 'i', 's' }),

         ['<C-h>'] = cmp.mapping(function()
         end, { 'i', 's' }),
      },
      sources = {
         { name = 'nvim_lsp' },
         { name = 'path' },
      },
   }
end,
  }
