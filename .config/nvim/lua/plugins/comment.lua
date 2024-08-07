return {
   'numToStr/Comment.nvim',
   lazy = true,
   config = true,
   init = function(plugin)
      local ft = require('Comment.ft')
      ft({'tac', 'tin'}, ft.get('cpp'))
   end,
}
