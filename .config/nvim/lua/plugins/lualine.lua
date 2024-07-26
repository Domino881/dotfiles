return {
   'nvim-lualine/lualine.nvim',
   opts = {
      options = {
         icons_enabled = false,
         component_separators = '',
         section_separators = '',
      },
      sections = {
         lualine_a = {'mode'},
         lualine_b = {},
         lualine_c = {'filename'},
         lualine_x = {'encoding', 'filetype'},
         lualine_y = {'progress'},
         lualine_z = {'location'}
      },
      inactive_sections = {
         lualine_a = {},
         lualine_b = {},
         lualine_c = {'filename'},
         lualine_x = {'location'},
         lualine_y = {},
         lualine_z = {}
      },
   }
}

