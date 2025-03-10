return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        {
            'j-hui/fidget.nvim',
            opts = {
                progress = {
                    poll_rate = 5,
                    suppress_on_insert = true,    -- Suppress new messages while in insert mode
                    ignore_done_already = true,   -- Ignore new tasks that are already complete
                    ignore_empty_message = false, -- Ignore new tasks that don't contain a message
                    display = {
                        render_limit = 1,
                        done_ttl = 0.8,
                        format_message = function(msg)
                            if string.find(msg.title, "Indexing") then
                                return nil -- Ignore "Indexing..." progress messages
                            end
                            if msg.message then
                                return msg.message
                            else
                                return msg.done and "✓" or "..."
                            end
                        end
                    }
                },
            }
        },
        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { 'folke/neodev.nvim',       opts = {} },
    },
    config = function()
        require('mason').setup()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend(
            'force',
            capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        require("mason-lspconfig").setup {
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
                "jedi_language_server",
                "basedpyright",
                "ruff",
                "clangd",
            },
            handlers = {
                function(server_name)
                    local server = {}
                    server.capabilities = capabilities
                    require('lspconfig')[server_name].setup(server)
                end,

                ["basedpyright"] = function()
                    require("lspconfig")["basedpyright"].setup({
                        settings = {
                            basedpyright = {
                                analysis = {
                                    diagnosticMode = "openFilesOnly",
                                    typeCheckingMode = "standard",
                                    stubPath = vim.fn.expand("$HOME/.local/share/stubs"),
                                    inlayHints = {
                                        callArgumentNames = true
                                    }
                                }
                            }
                        },
                        on_attach = function(client, _)
                            client.server_capabilities.hoverProvider = false
                        end
                    })
                end,

                ["ruff"] = function()
                    require("lspconfig")["ruff"].setup({
                        on_attach = function(client, _)
                            client.server_capabilities.hoverProvider = false
                        end
                    })
                end,

                ["jedi_language_server"] = function()
                    require("lspconfig").jedi_language_server.setup({
                        init_options = {
                            codeAction = {
                                nameExtractVariable = "Extract variable",
                                nameExtractFunction = "Extract function",
                            },
                            markupKindPreferred = "markdown",
                        },
                    })
                end,

                ["texlab"] = function()
                    require("lspconfig")["texlab"].setup({
                        settings = {
                            texlab = {
                                build = {
                                    executable = "latexrun",
                                },
                            }
                        },
                    })
                end,
            },
        }
    end,

    init = function()
        vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
                vim.lsp.buf.clear_references()
            end,
        })
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
                map('gr', require('telescope.builtin').lsp_references, 'Goto References')
                map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
                map('<leader>rn', vim.lsp.buf.rename, 'Rename')
                map('<leader>ca',
                    function()
                        vim.lsp.buf.code_action({ apply = true })
                    end, 'Code Action')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
            end,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { "source.organizeImports" } }
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                for cid, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                            vim.lsp.util.apply_workspace_edit(r.edit, enc)
                        end
                    end
                end
                vim.lsp.buf.format({ async = false })
            end
        })
        -- hover doesn't steal focus
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { focusable = false }
        )
    end,
}
