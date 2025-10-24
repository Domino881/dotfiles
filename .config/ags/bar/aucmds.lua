vim.api.nvim_create_augroup("ags", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = "ags",
    pattern = { "*.ts", "*.tsx", "*.scss" },
    callback = function(_)
        vim.cmd([[silent exec "!ags quit -i bar; ags run --gtk 3 -d ~/.config/ags/bar &"]])
    end,
})
