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
                local result = require("conform").format {
                    bufnr = this_buf,
                    async = true,
                    lsp_fallback = true,
                }
                if result then
                    require("fidget").notify(
                        "Formatted."
                    )
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
        format_on_save = false,
        lsp_format = "fallback",
        log_level = vim.log.levels.WARN,
        notify_no_formatters = true,

        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            tex = { "tex-fmt" },
        },

        formatters = {
            prettier = {
                prepend_args = {
                    "--plugin", "prettier-plugin-latex",
                    "--print-width", "75",
                    "--use-tabs", "false"
                },
            },
            latexindent = {
                prepend_args = {
                    "-m",
                    "-l",
                    "/home/dominik/Documents/latexindent.yaml",
                }
            },
            ["tex-fmt"] = {
                prepend_args = {
                    "--tabsize", "4",
                    "--wraplen", "85",
                }
            }
        }
    },
}
