return {
   'numToStr/Comment.nvim',
   config = true,
   init = function(plugin)
      local ft = require('Comment.ft')
      ft({'tac', 'tin'}, ft.get('cpp'))
   end,
}
