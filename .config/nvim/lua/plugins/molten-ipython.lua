return {
    "benlubas/molten-nvim",
    ft = { "python", "ipynb" },
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
        vim.keymap.set("n", "me", ":MoltenReevaluateCell<CR>",
            { silent = true, desc = "Molten Evaluate Cell" })
        vim.keymap.set("v", "me", ":<C-u>MoltenEvaluateVisual<CR>",
            { silent = true, desc = "Molten Evaluate Cell" })
        vim.keymap.set("n", "ms", ":noautocmd MoltenEnterOutput<CR>",
            { silent = true, desc = "Molten Show/enter Output" })
        vim.keymap.set("n", "mi", ":MoltenImagePopup<CR>",
            { silent = true, desc = "Molten Image Popup" })
        vim.keymap.set("n", "md", ":MoltenDeinit<CR>",
            { silent = true, desc = "Molten Deinit" })

        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_image_location = "float"
        vim.g.molten_output_win_style = "minimal"
        vim.g.molten_output_win_border = "rounded"
        vim.g.molten_auto_open_output = false
        vim.g.molten_output_virt_lines = false
        vim.g.molten_virt_text_output = true
        vim.g.molten_virt_text_max_lines = 2
        vim.g.molten_output_win_max_height = 20
        vim.g.molten_output_win_max_width = 78
        vim.g.molten_output_win_cover_gutter = false

        require("which-key").add({ "m", group = "Molten" })
        vim.cmd([[highlight link MoltenCell ColorColumn]])
    end,
}
