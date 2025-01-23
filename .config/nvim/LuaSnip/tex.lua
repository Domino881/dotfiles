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
            \end{equation*}
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
            \end{align*}
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

    ls.snippet(
        { trig = "BIT", dscr = "A LaTeX itemize environment", snippetType = "autosnippet" },
        fmt(
          [[
            \begin{itemize}
                \item <>
            \end{itemize}
          ]],
          -- The insert node is placed in the <> angle brackets
          { i(1) },
          { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "IMG", dscr = "LaTeX include graphics", snippetType = "autosnippet" },
        fmt( [[\includegraphics[width=<>\linewidth]{<>}]],
          -- The insert node is placed in the <> angle brackets
          { i(1), i(0) },
          { delimiters = "<>" })
    ),
}
