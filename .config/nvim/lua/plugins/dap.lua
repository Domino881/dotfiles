return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'rcarriga/nvim-dap-ui',
    },
    lazy = true,
    ft = { 'cpp' },
    init = function()
        require("overseer").enable_dap()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
        local api = vim.api
        local keymap_restore = {}
        dap.listeners.after['event_initialized']['me'] = function()
            for _, buf in pairs(api.nvim_list_bufs()) do
                local keymaps = api.nvim_buf_get_keymap(buf, 'n')
                for _, keymap in pairs(keymaps) do
                    if keymap.lhs == "K" then
                        table.insert(keymap_restore, keymap)
                        api.nvim_buf_del_keymap(buf, 'n', 'K')
                    end
                end
            end
            api.nvim_set_keymap(
                'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
        end

        dap.listeners.after['event_terminated']['me'] = function()
            for _, keymap in pairs(keymap_restore) do
                api.nvim_buf_set_keymap(
                    keymap.buffer,
                    keymap.mode,
                    keymap.lhs,
                    keymap.rhs,
                    { silent = keymap.silent == 1 }
                )
            end
            keymap_restore = {}
        end

        vim.cmd([[highlight DapUIStopNC guibg=#3c3836]])
        vim.cmd([[highlight DapUIStartNC guibg=#3c3836]])
        vim.cmd([[highlight DapUIPlayPauseNC guibg=#3c3836]])
        vim.cmd([[highlight DapUIRestartNC guibg=#3c3836]])
        vim.cmd([[highlight DapUIStepOutNC guibg=#3c3836]])
        vim.cmd([[highlight DapUIStepBackNC guibg=#3c3836]])
        vim.cmd([[highlight DapUIStepIntoNC guibg=#3c3836]])
        vim.cmd([[highlight DapUIStepOverNC guibg=#3c3836]])
    end,
    config = function()
        local dap = require"dap"
        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                command = 'codelldb',
                args = {"--port", "${port}"},
            }
        }
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }
        dap.configurations.cpp = {
            {
                name = "Compile C++ project with Makefile",
                type = "codelldb",
                request = "launch",
                preLaunchTask = "make main",
                postLaunchTask = "make clean",
                program = "bin/test",
            }
        }
    end,
}
