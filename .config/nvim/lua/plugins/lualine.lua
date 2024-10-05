return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'gruvbox-material',
            icons_enabled = false,
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    fmt = function(str, _)
                        return string.lower(str)
                    end,
                }
            },
            lualine_b = {
                { 'branch', icon = nil },
                'diff',
            },
            lualine_x = {
                'encoding',
                { 'filetype', icon = nil },
            },
        },
    }
}
