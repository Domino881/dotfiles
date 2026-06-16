require("mason").setup()
require("fidget").setup({
	progress = {
		poll_rate = 2,
		suppress_on_insert = true, -- Suppress new messages while in insert mode
		ignore_done_already = true, -- Ignore new tasks that are already complete
		ignore_empty_message = false, -- Ignore new tasks that don't contain a message
	},
	notification = {
		override_vim_notify = true,
		view = {
			line_margin = 2,
			reflow = "ellipsis",
		},
		window = {
			border = "none",
			x_padding = 0,
			align = "bottom",
			tabstop = 2,
			max_width = 0.3,
			max_height = 10,
		},
	},
})
require("lazydev").setup()

require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = {
		-- "lua_ls",
		"ty",
		"clangd",
		"tinymist",
	},
	-- handlers = {
	-- 	function(server_name)
	-- 		if not disabled_servers[server_name] then
	-- 			vim.notify("server_name")
	-- 			vim.lsp.enable(server_name)
	-- 		end
	-- 	end,
	-- },
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			format = {
				enable = false,
			},
		},
	},
})

-- vim.lsp.config("basedpyright", {
-- 	settings = {
-- 		basedpyright = {
-- 			analysis = {
-- 				diagnosticMode = "openFilesOnly",
-- 				typeCheckingMode = "standard",
-- 				-- stubPath = vim.fn.expand("$HOME/.local/share/stubs"),
-- 				inlayHints = {
-- 					callArgumentNames = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- vim.lsp.config("jedi_language_server", {
-- 	init_options = {
-- 		codeAction = {
-- 			nameExtractVariable = "Extract variable",
-- 			nameExtractFunction = "Extract function",
-- 		},
-- 		markupKindPreferred = "markdown",
-- 	},
-- })

vim.lsp.config("texlab", {
	filetypes = { "markdown", "tex", "bib" },
	settings = {
		texlab = {
			latexFormatter = "tex-fmt",
			build = {
				-- executable = "latexmk",
				-- args = { "-pvc", "%f" },
				-- args = { "--synctex", "--keep-logs", "--keep-intermediates", "%f" },
				onSave = false,
			},
			forwardSearch = {
				-- executable = "xdvik",
				-- args = { "-sourceposition <%l*%f>" },
				executable = "okular",
				args = { "--unique", "file:%p#src:%l%f" },
			},
			diagnostics = {
				ignoredPatterns = {
					"Unused label",
				},
			},
			hover = {
				symbols = "glyph",
			},
		},
	},
})

vim.lsp.config("ltex_plus", {
	filetypes = { "markdown", "tex", "bib" },
	settings = {
		ltex = {
			language = "en-GB",
			dictionary = {
				["en-GB"] = { vim.fn.stdpath("data") .. "/site/spell/en.utf-8.add" },
				["en-US"] = { vim.fn.stdpath("data") .. "/site/spell/en.utf-8.add" },
			},
		},
	},
})

vim.lsp.config("tinymist", {
	settings = {
		exportPdf = "onSave",
		rootPath = vim.fn.expand("$HOME"),
		formatterMode = "typstyle",
		formatterPrintWidth = 80,
		formatterProseWrap = true,
		formatterIndentSize = 4,
	},
})

vim.lsp.enable("julials")

vim.lsp.config("harper_ls", {
	filetypes = { "typst", "markdown", "text" },
	settings = {
		["harper-ls"] = {
			userDictPath = vim.fn.stdpath("data") .. "/site/spell/en.utf-8.add",
			linters = {
				LongSentences = false,
				MoreAdjective = false,
			},
			dialect = "British",
		},
	},
})

vim.lsp.config("bibtex-tidy", {
	filetypes = { "tex", "bib" },
	cmd = { "bibtex-tidy" },
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(modes, keys, func, desc)
			vim.keymap.set(modes, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("n", "gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
		map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, "Format buffer")
		map("n", "K", vim.lsp.buf.hover, "Hover with LSP")
	end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(modes, keys, func, desc)
			vim.keymap.set(modes, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("n", "gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
		map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, "Format buffer")
		map("n", "K", vim.lsp.buf.hover, "Hover with LSP")
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("lsp-format-on-write", { clear = true }),
	pattern = { "*.typ", "*.lua", "*.py" },
	callback = function(_)
		vim.lsp.buf.format({
			timeout_ms = 500,
		})

		require("fidget").notify("Formatted.")
	end,
})
