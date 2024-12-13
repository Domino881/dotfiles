return {
    "benlubas/molten-nvim",
    lazy = true,
    ft = { "python", "ipynb" },
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
        vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>",
            { silent = true, desc = "Re-evaluate cell" })
        vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>",
            { silent = true, desc = "Evaluate visual selection" })

        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
}
