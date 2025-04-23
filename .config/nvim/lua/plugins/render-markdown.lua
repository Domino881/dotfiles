return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    config = function()
        require("render-markdown").setup({
            render_modes = { "n", "c", "t", "i" },
            heading = {
                sign = false,
                icons = { "" },
                width = "block",
                min_width = 80,
                border = true,
                border_virtual = true,
                position = "inline",
                backgrounds = { "HtmlBold" },
            },
            bullet = {
                highlight = "Normal",
            },
            latex = { enabled = false },
            code = {
                --  none:     disables all rendering
                --  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
                --  language: adds language icon to sign column if enabled and icon + name above code blocks
                --  full:     normal + language
                style = "normal",
                position = "left",
                language_pad = 0,
                language_name = false,
                above = "▄",
                below = "▀",
                highlight = "RenderMarkdownCode",
            },
        })
    end,
}
