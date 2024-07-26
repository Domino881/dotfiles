return { -- Useful plugin to show you pending keybinds.
   'folke/which-key.nvim',
   event = 'VimEnter', -- Sets the loading event to 'VimEnter'
   config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup( {
         icons = {
            mappings = false,
            rules = false,
            keys = {
               C = "⌘",
               M = "Alt",
               CR = "↩",
               Esc = "<Esc>",
               BS = "<BS>",
               Space = "␣",
               Tab = "<Tab>",
               F1 = "F1",
               F2 = "F2",
               F3 = "F3",
               F4 = "F4",
               F5 = "F5",
               F6 = "F6",
               F7 = "F7",
               F8 = "F8",
               F9 = "F9",
               F10 = "F10",
               F11 = "F11",
               F12 = "F12",
            },
         },
      })

      -- Document existing key chains
      require('which-key').add {
         { "<leader>c", group = "[C]ode" },
         { "<leader>c_", hidden = true },
         { "<leader>d", group = "[D]ocument" },
         { "<leader>d_", hidden = true },
         { "<leader>r", group = "[R]ename" },
         { "<leader>r_", hidden = true },
         { "<leader>s", group = "[S]earch" },
         { "<leader>s_", hidden = true },
         { "<leader>t", group = "[T]oggle" },
         { "<leader>t_", hidden = true },
         { "<leader>w", group = "[W]orkspace" },
         { "<leader>w_", hidden = true },
      }
      -- visual mode
      require('which-key').add {
         { "<leader>gc", group = "[C]omment" },
         { "<leader>gcc", desc = "[C]omment lines" },
         { "<leader>gcb", desc = "[C]omment lines in block mode" },
         { "<leader>h", group = "[H]arpoon" },
         { "<leader>lf", desc = "Py[L]int [F]ormat Buffer" },
      }
   end,
}
