local ls = require("luasnip")
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	ls.snippet(
		{ trig = "#cetz", dscr = "The CetZ canvas" },
		fmt(
			[[
              #cetz.canvas({
                import cetz.draw: *
                <>
              })
          ]],
			-- The insert node is placed in the <> angle brackets
			{ i(0) },
			{ delimiters = "<>" }
		)
	),
}
