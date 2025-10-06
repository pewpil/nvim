return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,

				-- python
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.mypy,

				-- eslint
				require("none-ls.formatting.eslint_d"),
				require("none-ls.diagnostics.eslint_d"),
				require("none-ls.code_actions.eslint_d"),

				null_ls.builtins.formatting.prettier,
			},
		})

		local opts = {}
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)
	end,
}
