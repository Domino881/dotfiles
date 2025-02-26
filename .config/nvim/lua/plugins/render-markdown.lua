return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    lazy = true,
    ft = { 'markdown' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    config = function()
        vim.cmd([[hi RenderMarkdownBullet guibg=NONE]])
        require "render-markdown".setup({
            code = {
                -- Determines how code blocks & inline code are rendered:
                --  none:     disables all rendering
                --  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
                --  language: adds language icon to sign column if enabled and icon + name above code blocks
                --  full:     normal + language
                style = 'normal',
                -- Determines where language icon is rendered:
                --  right: right side of code block
                --  left:  left side of code block
                position = 'left',
                -- Amount of padding to add around the language
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                language_pad = 0,
                -- Whether to include the language name next to the icon
                language_name = false,
                -- Used above code blocks for thin border
                above = '▄',
                -- Used below code blocks for thin border
                below = '▀',
                -- Highlight for code blocks
                highlight = 'RenderMarkdownCode',
            }
        })
    end,
}
