return {
    'lervag/vimtex',
    lazy = true,
    ft = { 'tex', 'markdown', 'bibtex' },
    init = function()
        vim.g.vimtex_view_enabled = true
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_mappings_enabled = false
        vim.g.vimtex_imaps_enabled = false
        vim.g.vimtex_syntax_enabled = false
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.keymap.set('n',
            '<leader>tc', vim.cmd.VimtexCompile,
            { desc = 'VimTex Compile' })
        vim.keymap.set('n',
            '<leader>ti', ":terminal texliveonfly %<CR>",
            { desc = 'Install Tex Dependencies for File' })
        vim.keymap.set('n',
            '<leader>tv', vim.cmd.VimtexView,
            { desc = 'VimTex View' })
        vim.keymap.set('n',
            '<leader>tt', vim.cmd.VimtexTocToggle,
            { desc = 'VimTex Toggle Table of Contents' })

        local augroup = vim.api.nvim_create_augroup("VimtexGroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            pattern = "VimtexEventCompiling",
            group = augroup,
            callback = function()
                vim.g.vimtex_compiler_status = 1
            end,
        })
        vim.api.nvim_create_autocmd("User", {
            pattern = "VimtexEventCompileSuccess",
            group = augroup,
            callback = function()
                vim.g.vimtex_compiler_status = 2
            end,
        })
        vim.api.nvim_create_autocmd("User", {
            pattern = "VimtexEventCompileFailed",
            group = augroup,
            callback = function()
                vim.g.vimtex_compiler_status = -1
            end,
        })
        vim.api.nvim_create_autocmd("User", {
            pattern = { "VimtexEventInitPost", "VimtexEventCompileStopped" },
            group = augroup,
            callback = function()
                vim.g.vimtex_compiler_status = 0
            end,
        })
        vim.api.nvim_create_autocmd("User", {
            pattern = "VimtexEventQuit",
            group = augroup,
            callback = function()
                vim.g.vimtex_compiler_status = nil
                vim.cmd([[ call vimtex#compiler#clean(0) ]])
            end,
        })
    end
}
