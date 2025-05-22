return {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    opts = {
        force_buffers = true,
        layouts = {
            {
                elements = {
                    -- Elements can be strings or table with id and size keys.
                    { id = "scopes", size = 0.5 },
                    "breakpoints",
                    "watches",
                    "repl",
                },
                size = 50, -- 40 columns
                position = "left",
            },
            {
                elements = {
                    "console",
                },
                size = 0.25, -- 25% of total lines
                position = "bottom",
            },
        },
    }
}
