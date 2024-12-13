return {
    'rcarriga/nvim-notify',
    lazy = true,
    init = function()
        vim.notify = require"notify"
    end,
    opts = {
        render = "minimal",
        top_down = true,
        minimum_width = 30,
        stages = "static",
        background_colour = "#222222",
    }
}
