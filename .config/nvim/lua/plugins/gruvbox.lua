return{
   "ellisonleao/gruvbox.nvim",
   priority = 1000,
   config = true,
   opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = false,
      underline = false,
      bold = false,
      italic = {
         strings = false,
         emphasis = false,
         comments = false,
         operators = false,
         folds = false,
      },
      strikethrough = false,
      invert_selection = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      overrides = {
         ColorColumn = {bg = "#171717"},
         SignColumn = {bg = "#000000"},
         NonText = {fg = "#413b35"},
         Normal = {bg = "#000000"},
     }
   }
}
