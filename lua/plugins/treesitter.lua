return {
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = 'master', 
        lazy = false, 
        build = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { 
                    "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
                    "arduino", "bash", "cpp", "css", "csv", "gitignore", "go", "html",
                    "javascript", "json", "sql", "typescript"
                },

                sync_install = false,

                auto_install = true,

                highlight = {
                    enable = true,
                },

                indent = {
                    enable = true
                }
            }
        end
    }
}
