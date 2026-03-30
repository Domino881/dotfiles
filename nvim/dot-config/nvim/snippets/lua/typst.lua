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
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
local cond_obj = require("luasnip.extras.conditions")

local MATH_NODES = {
	math = true,
	formula = true,
}

local in_mathzone = cond_obj.make_condition(function()
	local node = vim.treesitter.get_node({ ignore_injections = false })
	while node do
		if MATH_NODES[node:type()] then
			return true
		end
		node = node:parent()
	end
	return false
end)

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
	-- ls.snippet(
	-- 	{ trig = "vb", name = "Vector Bold", snippetType = "autosnippet" },
	-- 	fmt([[vb(<>)<>]], { i(1), i(0) }, { delimiters = "<>" }),
	-- 	{ condition = in_mathzone }
	-- ),
	ls.snippet(
		{ trig = "sqrt", name = "Square Root", snippetType = "autosnippet" },
		fmt([[sqrt(<>)<>]], { i(1), i(0) }, { delimiters = "<>" }),
		{ condition = in_mathzone }
	),
	ls.snippet(
		{ trig = "abs", snippetType = "autosnippet" },
		fmt([[abs(<>)<>]], { i(1), i(0) }, { delimiters = "<>" }),
		{ condition = in_mathzone }
	),
	ls.snippet(
		{ trig = "cal", snippetType = "autosnippet" },
		fmt([[cal(<>)<>]], { i(1), i(0) }, { delimiters = "<>" }),
		{ condition = in_mathzone }
	),
	ls.snippet(
		{ trig = "dv", snippetType = "autosnippet" },
		fmt([[dv(<>)<>]], { i(1), i(0) }, { delimiters = "<>" }),
		{ condition = in_mathzone }
	),
	ls.snippet(
		{ trig = "pdv", snippetType = "autosnippet" },
		fmt([[pdv(<>)<>]], { i(1), i(0) }, { delimiters = "<>" }),
		{ condition = in_mathzone }
	),
	ls.snippet(
		{ trig = "(%a+)dag", desc = "Dagger", regTrig = true, snippetType = "autosnippet" },
		f(function(_, snip)
			return snip.captures[1] .. "^dagger"
		end, {}),
		{ condition = in_mathzone }
	),
	ls.snippet(
		{ trig = "par", desc = "Partial", snippetType = "autosnippet" },
		t("partial"),
		{ condition = in_mathzone }
	),
	ls.snippet(
		{ trig = "(%a+)(%d)", desc = "Subscript index", regTrig = true, snippetType = "autosnippet" },
		f(function(_, snip)
			return snip.captures[1] .. "_" .. snip.captures[2]
		end, {}),
		{ condition = in_mathzone }
	),
}
