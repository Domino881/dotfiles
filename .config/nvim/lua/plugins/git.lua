return {
    'tpope/vim-fugitive',
    {
        'rbong/vim-flog',
        lazy = true,
        cmd = { 'Flog', 'Flogsplit', 'Floggit' },
        dependencies = {
            'tpope/vim-fugitive',
        },
        init = function()
            vim.g.flog_default_opts = {
                max_count = 2000,
                date = 'short',
                format = '[%h] %s %d',
                all = true,
            }
            vim.g.flog_enable_dynamic_commit_hl = true
        end,
    }
}
