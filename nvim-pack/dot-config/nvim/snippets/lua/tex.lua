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

local function title_to_label(args, parent, user_args)
    local title_text = args[1][1]
    -- Use text form of equations
    title_text = string.gsub(title_text, "\\texorpdfstring{.+}{(.+)}", "%1")
    -- Remove spaces
    title_text = string.gsub(title_text, "[ ^\\_]", "")
    return title_text
end

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
                \caption{<>}
                \label{<>}
            \end{figure}
          ]],
            -- The insert node is placed in the <> angle brackets
            { i(1), i(2), i(3) },
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
        fmt([[\includegraphics[width=<>\linewidth]{<>}]],
            -- The insert node is placed in the <> angle brackets
            { i(1), i(0) },
            { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "SEC", dscr = "A LaTeX section", snippetType = "autosnippet" },
        fmt(
            [[
            \section{<>}
            \label{sec:<>}
                <>
            % End section <>
          ]],
            -- The insert node is placed in the <> angle brackets
            { i(1), f(title_to_label, { 1 }), i(0), f(title_to_label, { 1 }) },
            { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "SSEC", dscr = "A LaTeX subsection", snippetType = "autosnippet" },
        fmt(
            [[
            \subsection{<>}
            \label{sec:<>}
                <>
            % End subsection <>
          ]],
            -- The insert node is placed in the <> angle brackets
            { i(1), f(title_to_label, { 1 }), i(0), f(title_to_label, { 1 }) },
            { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "SSEC", dscr = "A LaTeX subsubsection", snippetType = "autosnippet" },
        fmt(
            [[
            \subsubsection{<>}\label{sec:<>}
                <>
            % End subsubsection <>
          ]],
            -- The insert node is placed in the <> angle brackets
            { i(1), f(title_to_label, { 1 }), i(0), f(title_to_label, { 1 }) },
            { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "CHA", dscr = "A LaTeX chapter", snippetType = "autosnippet" },
        fmt(
            [[
            \chapter{<>}\label{cha:<>} % {{{
                <>
            % End chapter <> }}}
          ]],
            -- The insert node is placed in the <> angle brackets
            { i(1), f(title_to_label, { 1 }), i(0), f(title_to_label, { 1 }) },
            { delimiters = "<>" })
    ),

    ls.snippet(
        { trig = "BWR", dscr = "A LaTeX wrapfigure environment", snippetType = "autosnippet" },
        fmt(
            [[
            \begin{wrapfigure}{r}{0.5\textwidth}
                \begin{center}
                    <>
                \end{center}
                \caption{<>}
                \label{<>}
            \end{wrapfirure}
          ]],
            -- The insert node is placed in the <> angle brackets
            { i(1), i(2), i(3) },
            { delimiters = "<>" })
    ),


    ls.snippet(
        {trig = ";a", dscr = "Greek letter alpha", snippetType = "autosnippet"},
        fmt("\\alpha", {},{delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";b", dscr = "Greek letter beta", snippetType = "autosnippet"},
        fmt("\\beta", {}, {delimiters="<>"})
    ),

    ls.snippet(
        {trig = ";g", dscr = "Greek letter gamma", snippetType = "autosnippet"},
        fmt("\\gamma", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";d", dscr = "Greek letter delta", snippetType = "autosnippet"},
        fmt("\\delta", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";e", dscr = "Greek letter epsilon", snippetType = "autosnippet"},
        fmt("\\epsilon", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";f", dscr = "Greek letter phi", snippetType = "autosnippet"},
        fmt("\\phi", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";o", dscr = "Greek letter omega", snippetType = "autosnippet"},
        fmt("\\omega", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";r", dscr = "Greek letter rho", snippetType = "autosnippet"},
        fmt("\\rho", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";t", dscr = "Greek letter tau", snippetType = "autosnippet"},
        fmt("\\tau", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";n", dscr = "Greek letter nu", snippetType = "autosnippet"},
        fmt("\\nu", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";m", dscr = "Greek letter mu", snippetType = "autosnippet"},
        fmt("\\mu", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";b", dscr = "Greek letter beta", snippetType = "autosnippet"},
        fmt("\\beta", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";t", dscr = "Greek letter theta", snippetType = "autosnippet"},
        fmt("\\theta", {}, {delimiters="<>"})
    ),
    ls.snippet(
        {trig = ";h", dscr = "Greek letter psi", snippetType = "autosnippet"},
        fmt("\\psi", {}, {delimiters="<>"})
    ),

}
