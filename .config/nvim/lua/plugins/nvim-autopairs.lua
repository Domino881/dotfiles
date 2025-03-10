return {
    'windwp/nvim-autopairs',
    config = true,
    event = 'InsertEnter',
    init = function()
        local Rule = require('nvim-autopairs.rule')
        local npairs = require('nvim-autopairs')
        local cond = require('nvim-autopairs.conds')

        npairs.add_rules({
            Rule("$", "$", { "tex", "latex" })
            -- don't move right when repeat character
                :with_move()
        })
    end,
}
