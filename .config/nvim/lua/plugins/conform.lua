return { -- Autoformat
   "stevearc/conform.nvim",
   lazy = true,
   event = "VeryLazy",
   keys = {
      {
         "<leader>f",
         function(bufnr)
            local fidget = require("fidget")
            local conform = require("conform")
            conform.format({ async = false })
            fidget.notify("Finished formatting")
         end,
         mode = "v",
         desc = "[F]ormat buffer",
      },
   },
   opts = {
      notify_on_error = true,
      notify_no_formatters = true,
      format_on_save = false,
      default_format_opts = {
         async = true,
      },
      formatters = {
         stylua = {
            prepend_args = {
               "--indent-width=" .. tostring(vim.o.shiftwidth),
               "--indent-type=Spaces",
            },
         },
         yapf = {
            prepend_args = {
               "--style={space_inside_brackets: True, indent_width: 3}"
            }
         }
      },
      formatters_by_ft = {
         lua = { "stylua" },
         python = { "yapf", lspformat = "fallback" },
      },
   },
}
