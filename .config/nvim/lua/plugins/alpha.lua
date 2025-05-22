return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local alpha = require 'alpha'
        local theta = require 'alpha.themes.theta'
        vim.api.nvim_set_hl(0, "GraemeLogo1", { fg = "#abfa8e" })
        vim.api.nvim_set_hl(0, "GraemeLogo2", { fg = "#8dec6a" })
        vim.api.nvim_set_hl(0, "GraemeLogo3", { fg = "#69d841" })
        vim.api.nvim_set_hl(0, "GraemeLogo4", { fg = "#6ace46" })
        vim.api.nvim_set_hl(0, "GraemeLogo5", { fg = "#58b337" })
        vim.api.nvim_set_hl(0, "GraemeLogo6", { fg = "#408726" })
        vim.api.nvim_set_hl(0, "GraemeLogo7", { fg = "#3a7b23" })
        vim.api.nvim_set_hl(0, "GraemeLogo8", { fg = "#336b1e" })
        vim.api.nvim_set_hl(0, "GraemeLogo9", { fg = "#2b5b1a" })
        vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#70f8ff" })
        vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#2ddde6" })
        vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#22adb4" })
        vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#2d9095" })
        vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#2b6f73" })
        vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#37787b" })
        vim.api.nvim_set_hl(0, "NeovimDashboardUsername", { fg = "#436d70" })
        theta.nvim_web_devicons.enabled = false
        theta.header.type = "group"
        theta.header.val = {
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
                require "alpha.themes.dashboard".button(".", "Open Current Dir", ":e . <CR>"),
            },

            alpha.setup(theta.config)
    end
}
