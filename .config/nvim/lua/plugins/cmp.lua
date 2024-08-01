return { -- Autocompletion
   'hrsh7th/nvim-cmp',
   event = "InsertEnter",
   dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      {'hrsh7th/cmp-cmdline', event="CmdlineEnter"},
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
            { name = 'buffer' },
         },
      }
      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
         mapping = cmp.mapping.preset.cmdline(),
         sources = cmp.config.sources({
            { name = 'path', },
            {
               name = 'cmdline',
               option = {
                  ignore_cmds = { 'w', 'wq', 'q', '!' }
               },
               keyword_length = 999,
            },
      })
   })
end,
}
