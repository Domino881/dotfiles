return {
    "windwp/nvim-autopairs",
    config = true,
    event = "InsertEnter",
    init = function()
        local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")
        local cond = require("nvim-autopairs.conds")

        -- If you want insert `(` after select function or method item
        -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        -- local cmp = require("cmp")
        -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        npairs.get_rules("`")[1].not_filetypes = { "tex", "latex" }
        npairs.add_rules({
            Rule("$", "$", { "tex", "latex" })
                -- don't move right when repeat character
                :with_move(),
        })
        npairs.add_rules({
            Rule("``", "''", { "tex", "latex" }):with_move(),
        })
    end,
}
