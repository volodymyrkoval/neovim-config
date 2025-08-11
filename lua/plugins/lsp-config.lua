return {
    {
        "mason-org/mason.nvim",
        opts = {},
        config = function()
            require('mason').setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { 
                    "lua_ls", "ts_ls"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require('lspconfig').lua_ls.setup({})
            require('lspconfig').ts_ls.setup({})

            local opts = { buffer = bufnr, noremap = true, silent = true }

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)          -- Go to definition
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)          -- Find references
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                -- Show documentation
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Rename
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions (fixes, refactors)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)        -- Previous error
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)        -- Next error

        end
    }
}
