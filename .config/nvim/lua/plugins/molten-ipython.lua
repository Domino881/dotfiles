return {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.molten_auto_image_popup = true
        vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>",
            { silent = true, desc = "re-evaluate cell" })
        vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>",
            { silent = true, desc = "evaluate visual selection" })
    end,
}
