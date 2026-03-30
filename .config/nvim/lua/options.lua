vim.g.default_colorscheme = "gruvbox"

vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

vim.opt.undodir = vim.fn.expand("$HOME/.vim/undodir")
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.laststatus = 2

vim.opt.background = "dark"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.cino = "p2s,(1,:1,g1,h2" -- indents
vim.opt.showmode = false -- don't show "--insert--"

vim.g.python_recommended_style = false
vim.g.python_indent = {
	open_paren = "shiftwidth()",
	nested_paren = "shiftwidth()",
	continue = "shiftwidth()",
}

-- color column
vim.opt.cc = "80"
vim.opt.signcolumn = "yes"

-- autocompletion based only on current buffer
vim.opt.complete = "."

vim.opt.list = true
vim.opt.listchars = { space = "·", tab = ">-", trail = "$" }

vim.opt.termguicolors = true

vim.opt.mouse = "n"

vim.opt.updatetime = 50

vim.diagnostic.config({
	severity_sort = true,
	float = {
		source = true,
		style = "minimal",
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.INFO] = "●",
		},
	},
	virtual_text = {
		virt_text_pos = "eol",
		format = function(diagnostic)
			local mes = diagnostic.message
			if diagnostic.source == "pylint" then
				local colon = string.find(mes, ":") or 0
				return string.sub(mes, colon + 1)
			elseif diagnostic.source == "pyflakes" then
				local colon = string.find(mes, ":") or 0
				return string.sub(mes, colon + 1)
			elseif diagnostic.source == "pycodestyle" then
				local colon = string.find(mes, ":") or 0
				return string.sub(mes, colon + 1 + 4)
			elseif diagnostic.source == "formatdiff" then
				return "formatdiff"
			end
			return mes
		end,
	},
})

vim.wo.foldlevel = 999
vim.wo.foldnestmax = 1
vim.o.foldenable = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.spelllang = "en_gb"

vim.opt.winborder = "rounded"

vim.api.nvim_create_augroup("user-writing", { clear = false })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = "user-writing",
	pattern = { "*.tex", "*.md", "*.typ" },
	callback = function(_)
		vim.opt_local.spell = true
		-- vim.opt_local.number = false
		-- vim.opt_local.relativenumber = false
		vim.opt_local.textwidth = 80
		vim.opt_local.sidescrolloff = 0
		vim.opt_local.sidescroll = 15
		vim.opt_local.cmdheight = 0
		-- vim.opt_local.signcolumn = "no"
	end,
})

vim.api.nvim_create_augroup("ags", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "ags",
	pattern = { vim.fn.expand("$HOME/.config/ags/") .. "*" },
	callback = function(_)
		vim.cmd([[silent exec "!$HOME/.config/ags/start.sh &"]])
	end,
})

vim.api.nvim_create_augroup("user-misc", { clear = true })
vim.api.nvim_create_autocmd({ "Filetype" }, {
	pattern = { "css", "scss" },
	group = "user-misc",
	callback = function()
		vim.bo.shiftwidth = 4
	end,
})

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

-- vim.loader.enable()
