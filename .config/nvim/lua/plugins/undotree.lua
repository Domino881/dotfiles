local keybind = '<leader>u'

return {
    'mbbill/undotree',
    lazy = true,
    keys = { keybind },
    config = function()
        vim.keymap.set('n', keybind, vim.cmd.UndotreeToggle, { desc = 'Open Undotree' })
        vim.g.undotree_WindowLayout = 3
        vim.g.undotree_SplitWidth = 58
    end,
}
