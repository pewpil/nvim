return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function()
			require("mason").setup()
			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"pyright",
					"eslint",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})
			vim.lsp.config("pyright", {
				capabilities = capabilities,
			})
			vim.lsp.config("eslint", {
				capabilities = capabilities,
			})
			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
			})
			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})
			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})
			vim.lsp.config("emmet_language_server", {
				capabilities = capabilities,
			})
			vim.lsp.enable({"lua_ls", "ts_ls", "pyright", "eslint", "rust_analyzer", "clangd", "cssls", "emmet_language_server"})

			-- lsp keymaps
			local opts = {}
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gk", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		end,
	},
}
