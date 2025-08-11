return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,      -- format JS/TS with Prettier
                    null_ls.builtins.diagnostics.eslint_d,    -- lint JS/TS with ESLint-D
                    null_ls.builtins.code_actions.eslint_d,   -- quick fixes from ESLint-D
				},
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
