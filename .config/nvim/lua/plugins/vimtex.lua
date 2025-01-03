return {
    'lervag/vimtex',
    lazy = true,
    ft = { 'tex', 'markdown', 'bibtex' },
    init = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_mappings_enabled = false
        vim.g.vimtex_syntax_enabled = false
        vim.keymap.set('n',
            '<leader>tc', vim.cmd.VimtexCompile,
            { desc = 'VimTex Compile' })
    end,
}
