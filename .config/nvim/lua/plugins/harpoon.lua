return {
   'ThePrimeagen/harpoon',
   config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon [A]dd current file" })
      vim.keymap.set("n", "<C-p>", ui.toggle_quick_menu)
   end,
}


