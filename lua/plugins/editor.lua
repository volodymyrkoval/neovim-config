-- Editor enhancement plugins
return {
    -- Syntax highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
        end,
    },

    -- Enhanced UI select
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },

    -- File explorer with custom logic
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    use_libuv_file_watcher = true,
                    follow_current_file = {
                        enabled = true,
                    },
                },
                default_component_configs = {
                    git_status = {
                        symbols = {
                            -- Git status symbols
                            added = "✚",
                            modified = "✱",
                            deleted = "✖",
                            renamed = "󰁕",
                            untracked = "★", -- Changed from ? to ★ for clarity
                            ignored = "◌",
                            unstaged = "✗",
                            staged = "✓",
                            conflict = "",
                        },
                    },
                },
            })

            -- Custom escape mapping setup function
            local function setup_escape_mapping()
                vim.defer_fn(function()
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
                        if ft == "neo-tree" then
                            vim.api.nvim_buf_set_keymap(
                                buf,
                                "n",
                                "<Esc>",
                                ":wincmd p<CR>",
                                { silent = true, noremap = true }
                            )
                        end
                    end
                end, 50)
            end

            -- Buffer-specific escape mapping
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*",
                callback = function()
                    if vim.bo.filetype == "neo-tree" then
                        vim.keymap.set("n", "<Esc>", function()
                            vim.cmd("wincmd p")
                        end, {
                            buffer = true,
                            silent = true,
                            desc = "Return to previous window",
                        })
                    end
                end,
            })

            -- Smart toggle function with preserved custom logic
            local function smart_neo_tree_toggle()
                local current_ft = vim.bo.filetype

                if current_ft == "neo-tree" then
                    vim.cmd("Neotree close")
                else
                    -- Check if Neo-tree is already open
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
                        if ft == "neo-tree" then
                            vim.api.nvim_set_current_win(win)
                            return
                        end
                    end
                    -- Open Neo-tree and set up escape mapping
                    vim.cmd("Neotree show focus")
                    setup_escape_mapping()
                end
            end

            vim.keymap.set("n", "<C-a>1", smart_neo_tree_toggle, { desc = "Smart Neo-tree toggle" })
        end,
    },
}