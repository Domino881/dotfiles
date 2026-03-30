vim.api.nvim_create_augroup("ags", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = "ags",
    pattern = { "*.ts", "*.tsx", "*.scss" },
    callback = function(_)
        vim.cmd([[silent exec "!ags quit -i osd; ags run -d ~/.config/ags/osd &"]])
    end,
})
