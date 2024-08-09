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
         mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-y>'] = cmp.mapping.confirm { select = true },
            ['<C-Space>'] = cmp.mapping.complete {},
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
