return {
   'lewis6991/gitsigns.nvim',
   opts = {
      signs = {
         add          = { text = '┃' },
         change       = { text = '┃' },
         delete       = { text = '_' },
         topdelete    = { text = '‾' },
         changedelete = { text = '~' },
         untracked    = { text = '┆' },
      },
      signs_staged = {
         add          = { text = '┃' },
         change       = { text = '┃' },
         delete       = { text = '_' },
         topdelete    = { text = '‾' },
         changedelete = { text = '~' },
         untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
         follow_files = true
      },
      auto_attach = true,
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
         -- Options passed to nvim_open_win
         border = 'single',
         style = 'minimal',
         relative = 'cursor',
         row = 0,
         col = 1
      },
   },
   init = function()
      vim.keymap.set('n', ']c', function()
         if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
         else
            require"gitsigns".nav_hunk('next')
         end
      end, {desc = "Next Git Hunk"})

      vim.keymap.set('n', '[c', function()
         if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
         else
            require"gitsigns".nav_hunk('prev')
         end
      end, {desc = "Previous Git Hunk"})
   end,
}
