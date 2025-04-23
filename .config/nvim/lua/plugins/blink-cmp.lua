return {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "1.*",
    dependencies = {
        { "L3MON4D3/LuaSnip", version = "v2.*" },
        -- compatibility layer for using nvim-cmp sources (like jupyter)
        { "saghen/blink.compat", lazy = true, config = true },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = "none",
            ["<C-space>"] = {
                "show",
                "show_documentation",
                "hide_documentation",
            },
            ["<C-y>"] = { "select_and_accept" },

            ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },

            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },

            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        signature = { enabled = true },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            documentation = { auto_show = false },
            -- 'prefix' will fuzzy match on the text before the cursor
            -- 'full' will fuzzy match on the text before _and_ after the cursor
            keyword = { range = "full" },
            menu = {
                auto_show = function(ctx, item)
                    if
                        vim.bo.filetype == "markdown"
                        or vim.bo.filetype == "tex"
                        or vim.bo.filetype == "typst"
                    then
                        return false
                    end
                    return true
                end,
                border = "padded",
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "source_name" },
                    },
                },
            },
            ghost_text = { enabled = true },
        },

        snippets = { preset = "luasnip" },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                jupyter = {
                    name = "jupyter",
                    module = "blink.compat.source",
                },
            },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
