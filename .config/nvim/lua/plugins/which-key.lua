return { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    lazy = true,
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
        preset = "modern",
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = true, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true,    -- misc bindings to work with windows
            z = true,      -- bindings for folds, spelling and others prefixed with z
            g = true,      -- bindings for prefixed with g
        },
        icons = {
            mappings = false,
            rules = false,
        },
        spec = {
            { "<leader>s", group = "Search", icon="" },
            { "<leader>c", group = "Code" },
            { "<leader>l", group = "Format" },
            { "<leader>r", group = "Rename" },
            { "<leader>t", group = "VimTex" },
            { "<leader>h", group = "Harpoon" },
            { "<leader>.", group = "Source" },
            { "gc",  group = "Comment" },
            { "gx", desc = "Open filepath or URI" },
            { "gcc", desc = "Comment lines" },
            { "<leader>u", desc = "Toggle Undotree" },
        }
    }
}
