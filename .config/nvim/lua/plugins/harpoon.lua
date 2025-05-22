local keybindAdd = '<leader>ha'
local keybindOpen = '\\'

return {
    'ThePrimeagen/harpoon',
    keys = { keybindAdd, keybindOpen },
    config = function()
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')
        vim.keymap.set('n', keybindAdd, mark.add_file, { desc = 'Harpoon Add Current File' })
        vim.keymap.set('n', keybindOpen, ui.toggle_quick_menu)
    end,
}
