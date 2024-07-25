return {
   "goolord/alpha-nvim",
   config = function ()
      local alpha = require'alpha'
      local theta = require'alpha.themes.theta'
      vim.api.nvim_set_hl(0, "GraemeLogo1", { fg = "#abfa8e", ctermfg=82 })
      vim.api.nvim_set_hl(0, "GraemeLogo2", { fg = "#8dec6a", ctermfg=82 })
      vim.api.nvim_set_hl(0, "GraemeLogo3", { fg = "#69d841", ctermfg=76 })
      vim.api.nvim_set_hl(0, "GraemeLogo4", { fg = "#6ace46", ctermfg=76 })
      vim.api.nvim_set_hl(0, "GraemeLogo5", { fg = "#58b337", ctermfg=70 })
      vim.api.nvim_set_hl(0, "GraemeLogo6", { fg = "#408726", ctermfg=64 })
      vim.api.nvim_set_hl(0, "GraemeLogo7", { fg = "#3a7b23", ctermfg=64 })
      vim.api.nvim_set_hl(0, "GraemeLogo8", { fg = "#336b1e", ctermfg=58 })
      vim.api.nvim_set_hl(0, "GraemeLogo9", { fg = "#2b5b1a", ctermfg=58 })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#70f8ff", ctermfg=87 })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#2ddde6", ctermfg=81 })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#22adb4", ctermfg=75 })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#2d9095", ctermfg=69 })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#2b6f73", ctermfg=63 })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#37787b", ctermfg=63 })
      vim.api.nvim_set_hl(0, "NeovimDashboardUsername", { fg = "#436d70" })
      theta.header.type = "group"
      theta.header.val = {
         {
            type = "text",
            val = "▄████  ██████   ▄▄▄      ▓█████  ███▄ ▄███▓▓█████ ▀ ██████ ",
            opts = { hl = "GraemeLogo1", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "██▒ ▀█▒▓██ ▒ ██▒▒████▄    ▓█   ▀ ▓███▄██ ██▒▓█   ▀ ▒██    ▒ ",
            opts = { hl = "GraemeLogo2", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "▒██░▄▄▄░▓██ ░▄█ ▒▒██  ▀█▄  ▒███   ▓██ █▀ ▓██░▒███   ░ ▓██▄   ",
            opts = { hl = "GraemeLogo3", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "░▓█  ██▓▒██▀▀█▄  ░██▄▄▄▄██ ▒▓█  ▄ ▒██    ▒██ ▒▓█  ▄   ▒   ██▒",
            opts = { hl = "GraemeLogo4", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "░▒▓███▀▒░██▓ ▒██▒ ▓█   ▓██▒░▒████▒▒██▒   ░██▒░▒████▒▒██████▒▒",
            opts = { hl = "GraemeLogo5", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "░▒   ▒ ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░░ ▒░ ░░ ▒░   ░  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░",
            opts = { hl = "GraemeLogo6", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "░   ░   ░▒ ░ ▒░  ▒   ▒▒ ░ ░ ░  ░░  ░      ░ ░ ░  ░░ ░▒  ░ ░",
            opts = { hl = "GraemeLogo7", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" },
         },
         {
            type = "text",
            val = "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            opts = { hl = "NeovimDashboardLogo6", shrink_margin = false, position = "center" },
         },
         {
            type = "padding",
            val = 1,
         },
      }
      theta.buttons.val = {
             require"alpha.themes.dashboard".button( ".", "Open Current Dir", ":e . <CR>"),
      },

      alpha.setup(theta.config)
   end
}
