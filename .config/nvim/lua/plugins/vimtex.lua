return {
    'lervag/vimtex',
    init = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.keymap.set('n',
            '<leader>tc', vim.cmd.VimtexCompile,
            { desc = 'Vim[T]ex [C]ompile' })
    end,
}
