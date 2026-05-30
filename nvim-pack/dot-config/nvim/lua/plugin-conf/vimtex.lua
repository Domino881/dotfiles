vim.g.vimtex_view_enabled = true
vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.g.vimtex_view_automatic = false
vim.g.vimtex_mappings_enabled = false
vim.g.vimtex_imaps_enabled = false
vim.g.vimtex_syntax_enabled = true
vim.g.vimtex_syntax_conceal_disable = true
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_silent = true

local augroup = vim.api.nvim_create_augroup("VimtexGroup", { clear = true })

vim.g.vimtex_continuous_enabled = false

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	pattern = "*.tex",
-- 	group = augroup,
-- 	callback = function()
-- 		if vim.g.vimtex_continuous_enabled then
-- 			vim.cmd("silent! VimtexCompile!")
-- 			vim.cmd("redraw!")
-- 		end
-- 	end,
-- })

local progress = require("fidget.progress")
local handle = nil
local compiler_expected_lines = 80.0
local compiler_lines = 0.0
local fidget_key = "Vimtex"

vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventInitPost",
	group = augroup,
	callback = function()
		vim.keymap.set("n", "<leader>tc", function()
			if handle then
				handle:cancel()
			end
			handle = nil
			vim.cmd.VimtexCompile()
			vim.g.vimtex_continuous_enabled = not vim.g.vimtex_continuous_enabled
		end, { desc = "VimTex Compile" })
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

-- This is run on every line output by the compiler
function Callback(msg)
	compiler_lines = compiler_lines + 1
	if msg.find(msg, "^vimtex_compiler_callback_compiling") then
		handle = progress.handle.create({
			title = "Vimtex compiling...",
			message = "",
			lsp_client = { name = "Vimtex" },
			percentage = 0,
			token = fidget_key,
		})
		return
	end
	if handle == nil then
		return
	end
	handle.percentage = math.min(99, math.floor(100 * compiler_lines / compiler_expected_lines))

	if msg.find(msg, "^vimtex_compiler_callback_success") then
		handle:finish()
		compiler_expected_lines = math.max(compiler_expected_lines, compiler_lines)
		compiler_lines = 0.0
		handle = nil
		return
	elseif msg.find(msg, "^vimtex_compiler_callback_failure") then
		handle.title = "Vimtex Error"
		handle:cancel()
		compiler_lines = 0.0
		handle = nil
		return
	end
end
vim.g.vimtex_compiler_latexmk = { hooks = { Callback } }

vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileStarted",
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = 1
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileSuccess",
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = 2
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileFailed",
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = -1
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = { "VimtexEventInitPost", "VimtexEventCompileStopped" },
	group = augroup,
	callback = function()
		vim.g.vimtex_compiler_status = 0
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
