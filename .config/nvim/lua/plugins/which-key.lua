return {                -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
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
            { "<leader>c",  group = "[C]ode" },
            { "<leader>c_", hidden = true },
            { "<leader>d",  group = "[D]ocument" },
            { "<leader>d_", hidden = true },
            { "<leader>r",  group = "[R]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>s",  group = "[S]earch" },
            { "<leader>s_", hidden = true },
            { "<leader>t",  group = "[T]oggle" },
            { "<leader>t_", hidden = true },
            { "<leader>w",  group = "[W]orkspace" },
            { "<leader>w_", hidden = true },
        }
        -- visual mode
        require('which-key').add {
            { "<leader>gc",  group = "[C]omment" },
            { "<leader>gcc", desc = "[C]omment lines" },
            { "<leader>gcb", desc = "[C]omment lines in block mode" },
            { "<leader>h",   group = "[H]arpoon" },
            { "<leader>lf",  desc = "Py[L]int [F]ormat Buffer" },
        }
    end,
}
