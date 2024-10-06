local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    ls.snippet(
        { trig = "\\begin", dscr = "A LaTeX environment", snippetType = "autosnippet" },
        fmt(
          [[
            \begin{<>}
                <>
            \end{<>}
          ]],
          -- The insert node is placed in the <> angle brackets
          { i(1), i(2), rep(1) },
          { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "BEQ", dscr = "A LaTeX equation* environment", snippetType = "autosnippet" },
        fmt(
          [[
            \begin{equation*}
                <>
            \end{equation}
          ]],
          -- The insert node is placed in the <> angle brackets
          { i(1) },
          { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "BAL", dscr = "A LaTeX align* environment", snippetType = "autosnippet" },
        fmt(
          [[
            \begin{align*}
                <>
            \end{align}
          ]],
          -- The insert node is placed in the <> angle brackets
          { i(1) },
          { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "BFI", dscr = "A LaTeX figure environment", snippetType = "autosnippet" },
        fmt(
          [[
            \begin{figure}
                <>
            \end{figure}
          ]],
          -- The insert node is placed in the <> angle brackets
          { i(1) },
          { delimiters = "<>" })
    ),

    s({ trig = ";a", dscr = "Greek letter alpha", snippetType = "autosnippet" },
        { t("\\alpha") }
    ),
    s({ trig = ";b", dscr = "Greek letter beta", snippetType = "autosnippet" },
        { t("\\beta") }
    ),
    s({ trig = ";g", dscr = "Greek letter gamma", snippetType = "autosnippet" },
        { t("\\gamma") }
    ),
    s({ trig = ";d", dscr = "Greek letter delta", snippetType = "autosnippet" },
        { t("\\delta") }
    ),
    s({ trig = ";y", dscr = "Greek letter psi", snippetType = "autosnippet" },
        { t("\\psi") }
    ),
}
