return{
    '3rd/image.nvim',
    lazy = true,
    version = "1.1.0",
    opts = {
        backend = "kitty",
        integrations = {
            markdown = { enabled = true },
        },
        max_width = 400,
        max_height = 12,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        tmux_show_only_in_active_window = true,
    }
}
