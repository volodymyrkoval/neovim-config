-- Autocompletion and snippets configuration
return {
    -- Snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets", -- Pre-built snippets
        },
        config = function()
            local luasnip = require("luasnip")
            
            -- Load snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()
            
            -- Enable autotrigger
            luasnip.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            })

            -- Snippet navigation keymaps
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { desc = "Expand or jump forward in snippet" })

            vim.keymap.set({ "i", "s" }, "<C-h>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { desc = "Jump backward in snippet" })
        end,
    },

    -- Completion engine
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
            "hrsh7th/cmp-buffer",       -- Buffer completion source  
            "hrsh7th/cmp-path",         -- Path completion source
            "hrsh7th/cmp-cmdline",      -- Command line completion source
            "saadparwaiz1/cmp_luasnip", -- Snippet completion source
            "L3MON4D3/LuaSnip",         -- Snippet engine
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ 
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true 
                    }),
                    
                    -- Tab completion
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip", priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                }),

                formatting = {
                    format = function(entry, vim_item)
                        -- Add icons for different sources
                        local icons = {
                            nvim_lsp = "󰘦",
                            luasnip = "󰩫",
                            buffer = "󰦪",
                            path = "󰉋",
                        }
                        
                        vim_item.kind = string.format("%s %s", icons[entry.source.name] or "󰎤", vim_item.kind)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        
                        return vim_item
                    end,
                },

                experimental = {
                    ghost_text = true,
                },
            })

            -- Command line completion
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}