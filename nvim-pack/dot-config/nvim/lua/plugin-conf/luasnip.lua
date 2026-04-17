local ls = require("luasnip")
ls.config.setup({ enable_autosnippets = true })

vim.keymap.set({ "i" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/lua"})
