return { -- Autoformat
    "stevearc/conform.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
        {
            "gf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "v",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        notify_on_error = true,
        format_on_save = false,
        lsp_format = "fallback",

        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
        },
    },
}
