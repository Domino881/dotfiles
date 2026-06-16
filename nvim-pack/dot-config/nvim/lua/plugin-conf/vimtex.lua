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
		vim.g.vimtex_compiler_status = 0
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
function Callback(_)
	compiler_lines = compiler_lines + 1
	if handle == nil then
		return
	end
	handle.percentage = math.min(99, math.floor(100 * compiler_lines / compiler_expected_lines))
end
vim.g.vimtex_compiler_latexmk = { hooks = { Callback } }

vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileStarted",
	group = augroup,
	callback = function()
		-- vim.notify("started")
		vim.g.vimtex_compiler_status = 1
		if handle ~= nil then
			handle:finish()
		end
		handle = progress.handle.create({
			title = vim.g.vimtex_compiler_method .. " compiling",
			message = "",
			lsp_client = { name = "Vimtex" },
			percentage = 0,
			token = fidget_key,
		})
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompiling",
	group = augroup,
	callback = function()
		-- vim.notify("compiling")
		vim.g.vimtex_compiler_status = 1
		if handle == nil then
			handle = progress.handle.create({
				title = vim.g.vimtex_compiler_method .. " compiling",
				message = "",
				lsp_client = { name = "Vimtex" },
				percentage = 0,
				token = fidget_key,
			})
		end
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileSuccess",
	group = augroup,
	callback = function()
		-- vim.notify("success")
		if handle then
			handle.message = "Success"
			handle:finish()
			compiler_expected_lines = math.max(compiler_expected_lines, compiler_lines)
			compiler_lines = 0.0
			handle = nil
		end
		vim.g.vimtex_compiler_status = 2
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileFailed",
	group = augroup,
	callback = function()
		-- vim.notify("failed")
		if handle then
			require("fidget").notify("Vimtex failed", vim.log.levels.ERROR, { key = fidget_key })
			handle.message = "Error"
			handle:cancel()
			compiler_lines = 0.0
			handle = nil
		end
		vim.g.vimtex_compiler_status = -1
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileStopped",
	group = augroup,
	callback = function()
		-- vim.notify("stopped")
		if handle then
			handle.message = "Canceled"
			handle:cancel()
			handle = nil
		end
		vim.g.vimtex_compiler_status = 0
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
