return {
    "stevearc/overseer.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    lazy = true,
    keys = { "<F5>", "<F6>" },
    init = function()
        vim.api.nvim_create_user_command("OverseerRestartLast", function()
            local overseer = require("overseer")
            local tasks = overseer.list_tasks({ recent_first = true })
            if vim.tbl_isempty(tasks) then
                vim.notify("No tasks found", vim.log.levels.WARN)
            else
                overseer.run_action(tasks[1], "restart")
            end
        end, {})
        require("overseer").register_template({
            name = "Run python file",
            builder = function(params)
                return {
                    cmd = { "python" },
                    args = { vim.fn.expand("%") },
                    name = "",
                    cwd = ".",
                    env = {},
                    components = { "default" },
                    metadata = {},
                }
            end,
            -- Optional fields
            tags = {},
            params = {},
            priority = 50,
            condition = {
                filetype = { "python" },
            },
        })
    end,
    opts = {
        -- Template modules to load
        templates = { "builtin" },
        dap = false,
        task_list = {
            direction = "bottom",
            bindings = {
                ["?"] = false,
                ["g?"] = "ShowHelp",
                ["<CR>"] = "RunAction",
                ["<C-e>"] = "Edit",
                ["o"] = "Open",
                ["<C-v>"] = "OpenVsplit",
                ["<C-s>"] = "OpenSplit",
                ["<C-f>"] = "OpenFloat",
                ["<C-q>"] = "OpenQuickFix",
                ["p"] = "TogglePreview",
                ["<C-l>"] = false,
                ["<C-h>"] = false,
                ["L"] = "IncreaseAllDetail",
                ["H"] = "DecreaseAllDetail",
                ["["] = "DecreaseWidth",
                ["]"] = "IncreaseWidth",
                ["{"] = "PrevTask",
                ["}"] = "NextTask",
                ["<C-k>"] = false,
                ["<C-j>"] = false,
                ["q"] = "Close",
            },
        },
    },
}
