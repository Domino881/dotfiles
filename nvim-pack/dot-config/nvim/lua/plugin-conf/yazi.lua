require("yazi").setup({
	open_for_directories = true,
	future_features = {
		process_events_live = false,
	},
    yazi_floating_window_border = "single",
})
vim.keymap.set("n", "-", "<cmd>Yazi<CR>")
vim.g.loaded_netrwPlugin = 1
