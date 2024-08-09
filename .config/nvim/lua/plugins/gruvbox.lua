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
         dark0_hard = "#000000", -- background
         dark2 = "#2d3533", -- listchars 
      },
      overrides = {
         SignColumn = {bg = ""},
         ColorColumn = {bg = "#171717"},
         GruvboxRedSign = {bg = ""},
         GruvboxYellowSign = {bg = ""},
         GruvboxBlueSign = {bg = ""},
     }
   }
}
