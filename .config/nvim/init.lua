vim.cmd('source $VIM/vimfiles/arista.vim')

require('options')
require('plugins')
require("ibl").setup()
require("ibl").update({scope = { show_end = false } })
require("cscope_maps").setup()

require('mappings')

vim.cmd('silent! colo gruvbox')

vim.g.markology_enable = 0

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'
vim.g.gruvbox_italic = 1

vim.g.markology_enable = 0

vim.cmd("hi MarkologyHLo ctermfg=0")
vim.cmd("highlight ColorColumn guibg=#111111")

vim.g.comfortable_motion_friction=500.0
vim.g.comfortable_motion_air_drag=0.0
vim.g.comfortable_motion_no_default_key_mappings = 1
vim.g.comfortable_motion_impulse_multiplier = 0.8

require('lualine').setup{
   sections = { lualine_b = {  }, lualine_x = { 'filetype' } }
}


--vim.g.ale_cpp_cc_options = '-std=c++20 -Wall'
--vim.g.ale_python_mypy_options = '--disable-error-code import-untyped'
--function! SmartInsertCompletion() abort
 --" Use the default CTRL-N in completion menus
 --if pumvisible()
   --return "\<C-n>"
 --endif
 --" Exit and re-enter insert mode, and use insert completion
 --return "\<C-c>a\<C-n>"
--endfunction


--vim.g.fzf_vim = {}
--" [Buffers] Jump to the existing window if possible
--let g:fzf_vim.buffers_jump = 0

--" [Tags] Command to generate tags file
--vim.g.fzf_vim.tags_command = 'ctags -R'
--" --sort --options=/home/dkuczynski/.ctags.conf'

--vim.g.NERDTreeWinSize = 42
--"let g:NERDTreeWinPos = 'right'

--vim.g.copy_mode = 0
--function Copy_mode_toggle()
   --if !g:copy_mode 
      --set nolist
      --set nonumber
      --set norelativenumber
      --set signcolumn=no
      --IndentLinesDisable
      --let g:copy_mode = 1
   --else
      --set list
      --set number
      --set relativenumber
      --set signcolumn=yes
      --IndentLinesEnable
      --let g:copy_mode = 0
   --endif
--endfunction
--vim.g.svndiff_autoupdate = 1

