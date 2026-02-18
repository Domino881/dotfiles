return {
    "let-def/texpresso.vim", -- instant LaTeX preview
    ft = { "tex" },
    init = function()
        require("texpresso").texpresso_path =
        vim.fn.expand("$HOME/.local/texpresso/build/texpresso")
    end,
}
