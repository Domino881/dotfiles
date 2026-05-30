require("treesitter-context").setup({
	max_lines = "10%",
})

require("nvim-treesitter").install({
	"bash",
	"c",
	"cpp",
	"diff",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"vim",
	"vimdoc",
})

local augroup = vim.api.nvim_create_augroup("user-treesitter", { clear = true })

-- Enable treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	group = augroup,
	callback = function()
		if vim.bo.filetype ~= "tex" then
			pcall(vim.treesitter.start)
		end
	end,
})

IGNORED_TS_PARSERS = {}
-- Ask to install missing parsers
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	group = augroup,
	callback = function()
		local ft = vim.bo.filetype
		local available_to_install = {}
		for _, l in ipairs(require("nvim-treesitter").get_available()) do
			available_to_install[l] = true
		end
		local installed = {}
		for _, l in ipairs(require("nvim-treesitter").get_installed()) do
			installed[l] = true
		end

		if (not ft) or installed[ft] or not available_to_install[ft] then
			return
		end
		if IGNORED_TS_PARSERS[ft] then
			return
		end
		local cmdheight = vim.o.cmdheight
		if cmdheight < 1 then
			vim.o.cmdheight = 1
		end
		local user_response = vim.fn.input("Install Treesitter parser for " .. ft .. "? [y/N]:")
		if user_response == "y" then
			require("nvim-treesitter").install(ft):wait(10)
		else
			IGNORED_TS_PARSERS[ft] = true
		end
		vim.opt_local.cmdheight = cmdheight
	end,
})
