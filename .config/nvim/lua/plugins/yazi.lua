return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        {
            "-",
            mode = { "n" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
    },
    ---@type YaziConfig | {}
    opts = {
        open_for_directories = true,
        future_features = {
            process_events_live = false,
        },
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
}
