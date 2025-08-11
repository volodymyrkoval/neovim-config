return {
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = 'master', 
        lazy = false, 
        build = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
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
