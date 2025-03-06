return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = { 'nvim-cmp' },
        lazy = true,
        opts = {
            history = true,
            delete_check_events = 'TextChanged',
            update_events = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
        },
        init = function()
            require('luasnip.loaders.from_lua').load {
                paths = { '~/.config/nvim/LuaSnip/lua' },
            }
        end,
    },
    {
        'iurimateus/luasnip-latex-snippets.nvim',
        dependencies = { 'L3MON4D3/LuaSnip', 'lervag/vimtex' },
        opts = { use_treesitter = true },
    },
}
