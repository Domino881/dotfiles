return{
   "ellisonleao/gruvbox.nvim",
   priority = 1000,
   config = true,
   opts = {
      terminal_colors = false, -- add neovim terminal colors
      undercurl = false,
      underline = true,
      bold = true,
      italic = {
         strings = false,
         emphasis = true,
         comments = true,
         operators = false,
         folds = false,
      },
      strikethrough = false,
      invert_selection = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      overrides = {
         ColorColumn = {bg = "#171717"},
         SignColumn = {bg = "#070505"},
         NonText = {fg = "#413b35"},
         Normal = {bg = "#070505"},
         GruvboxYellowSign = {bg = "#070505"},
         GruvboxRedSign = {bg = "#070505"},
         GruvboxBlueSign = {bg = "#070505"},
     }
   }
}
