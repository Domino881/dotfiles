return {
   'mbbill/undotree',
   init = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open [U]ndotree" })
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_SplitWidth = 58
   end,
}
