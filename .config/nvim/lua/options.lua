vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undodir = '~/.vim/undodir'
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.laststatus = 2

vim.opt.background = 'dark'

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.cino = 'p2s,(0,:1,g1,h2' -- indents
vim.opt.showmode = false -- don't show "--insert--"

-- color column
vim.opt.cc = "86"
vim.opt.signcolumn = "yes"

-- autocompletion based only on current buffer
vim.opt.complete = '.'

vim.opt.list = true
vim.opt.listchars = 'space:.,trail:⬗'

vim.opt.termguicolors = true

vim.opt.mouse = 'n'

vim.opt.updatetime = 50
