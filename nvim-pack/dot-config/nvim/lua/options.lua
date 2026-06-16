vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
local undodir = vim.fn.expand("$HOME/.local/share/nvim/undodir")
if not vim.fn.isdirectory(undodir) then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.laststatus = 2

vim.opt.background = "dark"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
-- vim.opt.cino = "p2s,(1,:1,g1,h2" -- indents
vim.opt.showmode = false -- don't show "--insert--"

-- color column
vim.opt.cc = "80"
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars = { space = "·", tab = ">-", trail = "$" }

vim.opt.termguicolors = true

vim.opt.mouse = "nv"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.spelllang = "en_gb"

-- vim.opt.winborder = "rounded"
vim.o.winborder = "🭽,▔,🭾,▕,🭿,▁,🭼,▏"
vim.opt.fillchars:append({
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
})

vim.opt.conceallevel = 0
vim.opt.concealcursor = "n"
vim.opt.foldenable = true
vim.opt.updatetime = 50
vim.wo.foldlevel = 999
vim.wo.foldnestmax = 1

vim.o.laststatus = 3

vim.diagnostic.config({
	severity_sort = true,
	float = {
		source = true,
		-- style = "minimal",
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.INFO] = "●",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	virtual_text = {
		virt_text_pos = "eol_right_align",
		prefix = function(diag, _, _)
			if diag.severity == vim.diagnostic.severity.HINT then
				return ""
			else
				return "🬋"
			end
		end,
	},
})

require("vim._core.ui2").enable()

------------------ AUTOCOMMANDS

vim.api.nvim_create_augroup("user-writing", { clear = false })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = "user-writing",
	pattern = { "*.tex", "*.md", "*.typ" },
	callback = function(_)
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 80
		vim.opt_local.sidescrolloff = 0
		vim.opt_local.sidescroll = 15
		-- vim.opt_local.cmdheight = 0
		vim.opt_local.comments:append({ "b:-", "b:*" })
		vim.opt_local.formatoptions:append("r")
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = "user-writing",
	pattern = "*.tex",
	callback = function(_)
		vim.keymap.set("i", ".,", "\\")
	end,
})
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
-- 	group = "user-writing",
-- 	pattern = { "*.tex", "*.md", "*.typ" },
-- 	callback = function(_)
-- 		vim.opt_local.number = false
-- 		vim.opt_local.relativenumber = false
-- 		vim.opt_local.signcolumn = "no"
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	group = "user-writing",
-- 	pattern = { "*.tex", "*.md", "*.typ" },
-- 	callback = function(_)
-- 		vim.opt_local.number = true
-- 		vim.opt_local.relativenumber = true
-- 		vim.opt_local.signcolumn = "yes"
-- 	end,
-- })

vim.api.nvim_create_augroup("user-floating", { clear = false })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = "user-floating",
	callback = function()
		local win = vim.api.nvim_get_current_win()
		-- Only target floating windows, not regular markdown buffers
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.wo[win].concealcursor = "n"
		end
	end,
})

------------------ USER COMMANDS

vim.api.nvim_create_user_command("Centerpad", function()
	vim.cmd([[22vnew]])
	vim.cmd([[set nonumber]])
	vim.cmd([[set norelativenumber]])
	vim.cmd([[set ft=pad]])
	vim.cmd([[PinBuffer]])
	vim.cmd([[wincmd l]])
end, {})

vim.api.nvim_create_user_command("WolframToTypst", function(tab)
	local range = tab.line1 .. "," .. tab.line2
	-- vim.cmd(range .. [[s/\[\(.\{-}\)\]/(\1)/ge]], {silent = true})
	vim.cmd(range .. [[s/\[/(/ge]])
	vim.cmd(range .. [[s/\]/)/ge]])
	vim.cmd(range .. [[s/\([a-z]\)\([0-9]\)/\1_\2/ge]])
	vim.cmd(range .. [[s/Sqrt/sqrt/ge]])
	vim.cmd(range .. [[s/E/e/ge]])
	vim.cmd(range .. [[s/I/i/ge]])
	vim.cmd(range .. [[s/Cos/cos/ge]])
	vim.cmd(range .. [[s/Sin/sin/ge]])

	-- vim.cmd(range .. [[join]])
	-- vim.cmd([[s/\([+-]\)/<CR>\1/ge]])
	-- vim.cmd([[s/<CR>/\r/ge]])
	vim.cmd([[s/\\(Pi)/pi/ge]])
end, { range = true })

vim.api.nvim_create_user_command("RestartRestore", "mksession! /tmp/session.vim | restart source /tmp/session.vim", {})
