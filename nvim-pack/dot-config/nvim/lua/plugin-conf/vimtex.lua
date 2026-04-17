vim.g.vimtex_view_enabled = true
vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.g.vimtex_mappings_enabled = false
vim.g.vimtex_imaps_enabled = false
vim.g.vimtex_syntax_enabled = false
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_compiler_method = "tectonic"

local augroup = vim.api.nvim_create_augroup("VimtexGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	group = augroup,
	callback = function()
        vim.cmd("silent! VimtexCompile!")
        vim.cmd("redraw!")
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventInitPost",
	group = augroup,
	callback = function()
		vim.keymap.set("n", "<leader>tc", vim.cmd.VimtexCompile, { desc = "VimTex Compile" })
		vim.keymap.set(
			"n",
			"<leader>ti",
			":terminal texliveonfly %<CR>",
			{ desc = "Install Tex Dependencies for File" }
		)
		vim.keymap.set("n", "<leader>tv", vim.cmd.VimtexView, { desc = "VimTex View" })
		vim.keymap.set("n", "<leader>tt", vim.cmd.VimtexTocToggle, { desc = "VimTex Toggle Table of Contents" })
	end,
})

local progress = require("fidget.progress")
local handle = nil

vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileStarted",
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = 1
        handle = progress.handle.create({
           message = "Vimtex compiling...",
           lsp_client = { name = "Vimtex" },
        })
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileSuccess",
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = 2
        if handle then
            handle:finish()
        end
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileFailed",
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = -1
        if handle then
            handle:cancel()
        end
        require("fidget").notify("VimTex Failed", "error")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = { "VimtexEventInitPost", "VimtexEventCompileStopped" },
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = 0
        if handle then
            handle:cancel()
        end
		if vim.bo.filetype == "markdown" then
			vim.g.vimtex_syntax_conceal_disable = 0
		end
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventQuit",
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = nil
		vim.cmd([[ call vimtex#compiler#clean(0) ]])
	end,
})
