return {
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
            -- Basic Neo-tree setup
            require("neo-tree").setup({})

            -- Function to set up Esc mapping
            local function setup_escape_mapping()
                vim.defer_fn(function()
                    -- Find neo-tree window and set mapping for its buffer
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
                        if ft == "neo-tree" then
                            vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", 
                                ":wincmd p<CR>", 
                                { silent = true, noremap = true })
                        end
                    end
                end, 50)  -- Small delay to ensure Neo-tree is fully loaded
            end

            -- Set up autocmd for when buffers change (handles file opening)
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*",
                callback = function()
                    if vim.bo.filetype == "neo-tree" then
                        vim.keymap.set("n", "<Esc>", function()
                            vim.cmd("wincmd p")
                        end, { 
                            buffer = true,
                            silent = true,
                            desc = "Go back to previous window" 
                        })
                    end
                end,
            })

            -- Smart toggle function
            local function smart_neo_tree_toggle()
                local current_ft = vim.bo.filetype

                if current_ft == "neo-tree" then
                    vim.cmd("Neotree close")
                else
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
                        if ft == "neo-tree" then
                            vim.api.nvim_set_current_win(win)
                            return
                        end
                    end
                    vim.cmd("Neotree show focus")
                    setup_escape_mapping()  -- Set up Esc after opening
                end
            end

            vim.keymap.set("n", "<C-a>1", smart_neo_tree_toggle, { desc = "Smart Neo-tree toggle" })
        end
    }
}
