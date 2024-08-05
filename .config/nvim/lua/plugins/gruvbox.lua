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
      palette_overrides = {
         dark0_hard = "#0e1010", -- background
         dark1 = "#2b2827", -- color column, popup
         dark2 = "#1d2021", -- listchars
      },
      overrides = {
         SignColumn = {bg = ""},
         GruvboxRedSign = {bg = ""},
         GruvboxYellowSign = {bg = ""},
         GruvboxBlueSign = {bg = ""},
     }
   }
}
