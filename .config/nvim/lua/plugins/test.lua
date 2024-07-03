local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local lines = {}
for w in string.gmatch(cmd_output, "([^\n]+)\n") do
    table.insert(lines, w)
end

-- our picker function: colors
local colors = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_table {
       results = results()
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

-- to execute the function
colors()
