return { -- Autoformat
    "stevearc/conform.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = { "j-hui/fidget.nvim" },
    keys = {
        {
            "<leader>lf",
            function()
                local this_buf = vim.fn.bufnr()
                local result = require("conform").format({
                    bufnr = this_buf,
                    async = true,
                    lsp_fallback = true,
                })
                if result then
                    require("fidget").notify("Formatted.")
                else
                    require("fidget").notify("Formatting failed.")
                end
            end,
            mode = "n",
            desc = "Format buffer",
        },
    },
    opts = {
        notify_on_error = true,
        format_on_save = function()
            if
                vim.bo.filetype == "python"
                or vim.bo.filetype == "cpp"
                or vim.bo.filetype == "typst"
                or vim.bo.filetype == "lua"
            then
                return { lsp_format = "fallback", timeout_ms = 500 }
            else
                return false
            end
        end,
        lsp_format = "fallback",
        log_level = vim.log.levels.WARN,
        notify_no_formatters = true,

        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            tex = { "tex-fmt", "prettier" },
            cpp = { "clang-format" },
            ["_"] = { "prettier" },
        },

        formatters = {
            stylua = {
                append_args = {
                    "--indent-width",
                    "4",
                    "--column-width",
                    "80",
                    "--indent-type",
                    "Spaces",
                },
            },
            prettier = {
                prepend_args = {
                    "--plugin",
                    "prettier-plugin-latex",
                    "--print-width",
                    "70",
                    "--use-tabs",
                    "false",
                    "--tab-width",
                    "4",
                },
            },
            latexindent = {
                prepend_args = {
                    "-m",
                },
            },
            ["tex-fmt"] = {
                prepend_args = {
                    "--tabsize",
                    "4",
                    "--wraplen",
                    "70",
                },
            },
        },
    },
}
