return { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        { 'hrsh7th/cmp-cmdline', event = "CmdlineEnter" },
        'saadparwaiz1/cmp_luasnip',
    },
    opts = function(_, opts)
        local cmp = require 'cmp'

        opts.snippet = {
            expand = function(args)
                require 'luasnip'.lsp_expand(args.body)
            end
        }
        opts.completion = { completeopt = 'menu,menuone,noinsert' }
        opts.mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            -- Scroll the documentation window [b]ack / [f]orward
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-y>'] = cmp.mapping.confirm { select = true },
            ['<C-Space>'] = cmp.mapping.complete {},

            ['<C-l>'] = cmp.mapping(function()
                require("luasnip").jump(1)
            end, { 'i', 's' }),

            ['<C-h>'] = cmp.mapping(function()
                require("luasnip").jump(-1)
            end, { 'i', 's' }),
        }
        opts.sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'luasnip' },
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
