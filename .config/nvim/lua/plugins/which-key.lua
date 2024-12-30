return { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    lazy = true,
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require('which-key').setup({
            icons = {
                mappings = false,
                rules = false,
                keys = {
                    C = "Ctrl",
                    M = "Alt",
                    CR = "↩",
                    Esc = "<Esc>",
                    BS = "<BS>",
                    Space = "␣",
                    Tab = "<Tab>",
                },
            },
        })

        -- Document existing key chains
        require('which-key').add {
            { "<leader>s", group = "Search" },
            { "<leader>c", group = "Code" },
            { "<leader>l", group = "Format" },
            { "<leader>r", group = "Rename" },
            { "<leader>t", group = "VimTex" },
        }
        -- visual mode
        require('which-key').add {
            { "gc",  group = "Comment" },
            { "gcc", desc = "Comment lines" },
        }
    end,
}
