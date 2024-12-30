return {
    "benlubas/molten-nvim",
    lazy = true,
    ft = { "python", "ipynb" },
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
        vim.keymap.set("n", "<leader>me", ":MoltenReevaluateCell<CR>",
            { silent = true, desc = "[M]olten [E]valuate Cell" })
        vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>",
            { silent = true, desc = "[M]olten [E]valuate Cell" })
        vim.keymap.set("n", "<leader>ms", ":noautocmd MoltenEnterOutput<CR>",
            { silent = true, desc = "[M]olten [S]how/enter Output" })

        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_image_location = "float"
        vim.g.molten_output_win_style = "minimal"
        vim.g.molten_output_win_border = "rounded"
        vim.g.molten_auto_open_output = false
        vim.g.molten_output_virt_lines = true
        vim.g.molten_virt_text_output = true
        vim.g.molten_output_win_max_height = 20
        vim.g.molten_output_win_max_width = 78
        vim.g.molten_output_win_cover_gutter = false
    end,
}
