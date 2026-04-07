require("mason").setup()
require("fidget").setup({
	progress = {
		poll_rate = 5,
		suppress_on_insert = true, -- Suppress new messages while in insert mode
		ignore_done_already = true, -- Ignore new tasks that are already complete
		ignore_empty_message = false, -- Ignore new tasks that don't contain a message
	},
	notification = {
		override_vim_notify = true,
	},
})
require("lazydev").setup()

require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = {
		"lua_ls",
		"ty",
		"clangd",
		"tinymist",
	},
	handlers = {
		function(server_name)
			vim.lsp.enable(server_name)
		end,
	},
})

vim.lsp.config("tinymist", {
	settings = {
		exportPdf = "onSave",
		outputPath = "$root/$dir/$name",
	},
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
	filetypes = { "markdown", "tex" },
	settings = {
		texlab = {
			latexFormatter = "tex-fmt",
			build = {
				executable = "latexrun",
			},
		},
	},
})

vim.lsp.config("ltex", {
	filetypes = { "markdown", "tex" },
	settings = {
		ltex = {
			language = "en-GB",
			disabledRules = {
				["en-GB"] = { "OXFORD_SPELLING_Z_NOT_S" },
			},
		},
	},
})

vim.lsp.config("tinymist", {
	settings = {
		exportPdf = "onSave",
		formatterMode = "typstyle",
		rootPath = vim.fn.expand("$HOME"),
	},
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
	pattern = { "*.typ", "*.lua" },
	callback = function(_)
		vim.lsp.buf.format({
			timeout_ms = 500,
		})
		vim.notify("Formatted.")
	end,
})
