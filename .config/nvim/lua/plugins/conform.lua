return { -- Autoformat
    "stevearc/conform.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = { 'j-hui/fidget.nvim' },
    keys = {
        {
            "<leader>lf",
            function()
                local this_buf = vim.fn.bufnr()
                local result = require("conform").format{
                    bufnr = this_buf,
                    async = false,
                    lsp_fallback = false,
                }
                if result then
                    require("fidget").notify(
                        "Formatted with " ..
                        require "conform".list_formatters_to_run(this_buf)[1].name
                    )
                else
                    require("fidget").notify("Formatting failed.")
                end
            end,
            mode = "n",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        notify_on_error = true,
        format_on_save = false,
        lsp_format = "fallback",
        log_level = vim.log.levels.WARN,
        notify_no_formatters = true,

        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            tex = { "prettier" },
        },

        formatters = {
            prettier = {
                prepend_args = {
                    "--plugin", "prettier-plugin-latex",
                    "--print-width", "75",
                    "--use-tabs", "false"
                },
            },
        }
    },
}
