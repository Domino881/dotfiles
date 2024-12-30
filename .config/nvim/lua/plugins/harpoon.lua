local keybindAdd = '<leader>ha'
local keybindOpen = '<C-p>'

return {
    'ThePrimeagen/harpoon',
    keys = { keybindAdd, keybindOpen },
    config = function()
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')
        vim.keymap.set('n', keybindAdd, mark.add_file, { desc = 'Harpoon Add current file' })
        vim.keymap.set('n', keybindOpen, ui.toggle_quick_menu)
        require('which-key').add({ "<leader>h", group = "Harpoon" })
    end,
}
