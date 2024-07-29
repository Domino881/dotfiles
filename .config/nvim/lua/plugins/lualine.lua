return {
   'nvim-lualine/lualine.nvim',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   opts = {
      options = {
         theme = 'gruvbox-material',
         icons_enabled = true,
         component_separators = '',
         section_separators = { left = '', right = '' },
      },
      sections = {
         lualine_b = {
            {'branch', icon = ''},
            'diff',
         },
         lualine_x = {
            'encoding',
            {'filetype', icon = nil},
         },
      },
   }
}

