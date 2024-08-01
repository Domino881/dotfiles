vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

vim.opt.undodir = os.getenv( "HOME" ) .. '/.vim/undodir'
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
vim.opt.cino = 'p2s,(1,:1,g1,h2' -- indents
vim.opt.showmode = false -- don't show "--insert--"

vim.g.python_recommended_style = false
vim.g.python_indent = {
   open_paren = 'shiftwidth()',
   nested_paren = 'shiftwidth()',
   continue = 'shiftwidth()'
}

-- color column
vim.opt.cc = "86"
vim.opt.signcolumn = "yes"

-- autocompletion based only on current buffer
vim.opt.complete = '.'

vim.opt.list = true
vim.opt.listchars = { trail = '⬗' }

vim.opt.termguicolors = false

vim.opt.mouse = 'n'

vim.opt.updatetime = 50

vim.diagnostic.config({
   float = { source = true, },
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel = 999
vim.wo.foldnestmax = 1

vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 58

vim.opt.ignorecase = true
vim.opt.smartcase = true
