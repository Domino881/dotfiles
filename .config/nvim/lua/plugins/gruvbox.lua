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
         strings = true,
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
         SignColumn = {bg = "#111111"},
         NonText = {fg = "#171717"},
         Normal = {bg = "#111111"},
         GruvboxRedSign = {fg = "#fb4934", bg = "#111111", bold=true},
         GruvboxYellowSign = {fg = "#fabd2f", bg = "#111111", bold=true},
         GruvboxBlueSign = {fg = "#83a598", bg = "#111111", bold=true},
     }
   }
}
