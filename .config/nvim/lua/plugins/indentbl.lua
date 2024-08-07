return {
   'lukas-reineke/indent-blankline.nvim',
   event = {'BufWinEnter', 'BufNewFile'},
   main = 'ibl',
   opts = {
      scope = {
         char = '▍',
         highlight = {'GruvboxBg1'},
      },
      indent = {
         char = '▎',
      }
   },
}
