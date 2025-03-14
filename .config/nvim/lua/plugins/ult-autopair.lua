return {
    'altermo/ultimate-autopair.nvim',
    lazy = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recommended as each new version will have breaking changes
    opts = {
        { '$',   '$',   ft = { 'tex', 'md' } },
        { '\\[', '\\]', ft = { 'tex' } },
    }
}
