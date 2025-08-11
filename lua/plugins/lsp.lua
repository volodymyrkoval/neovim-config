-- LSP and language server configurations
return {
    -- Package manager for LSP servers
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Bridge between mason and lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                },
                automatic_installation = true,
            })
        end,
    },

    -- Mason integration for none-ls tools
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "prettier", "eslint_d", "stylua" },
                automatic_installation = true,
            })
        end,
    },

    -- LSP configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- Get capabilities from nvim-cmp for LSP completion
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Configure LSP servers with completion capabilities
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })

            -- LSP keymaps (buffer-specific)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    -- Navigation
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

                    -- Documentation
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

                    -- Actions
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    -- Diagnostics
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

                    -- Formatting
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })
        end,
    },

    -- Formatting and linting
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local null_ls = require("null-ls")
            local eslint = require("none-ls.diagnostics.eslint_d")
            local eslint_code_actions = require("none-ls.code_actions.eslint_d")

            null_ls.setup({
                sources = {
                    -- Formatting
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,

                    -- Linting and code actions
                    eslint,
                    eslint_code_actions,
                },
            })

            -- Global formatting keymap
            vim.keymap.set("n", "<leader>gf", function()
                vim.lsp.buf.format({ async = true })
            end, { desc = "Format buffer" })
        end,
    },
}