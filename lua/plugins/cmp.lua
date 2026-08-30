return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",

		-- Adds file path completion capabilities
		"hrsh7th/cmp-path",

		-- Adds buffer completion capabilities
		"hrsh7th/cmp-buffer",

		-- Adds more completion capabilities
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-cmdline",

		-- friendly-snippets
		"rafamadriz/friendly-snippets",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
		luasnip.config.setup({})

		-- Extend javascriptreact and typescriptreact with html snippets
		luasnip.filetype_extend("javascriptreact", { "html" })
		luasnip.filetype_extend("typescriptreact", { "html" })

		local float_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		local float_winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None'
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				completion = { border = float_border, winhighlight = float_winhighlight, zindex = 1001, scrolloff = 0, col_offset = 0, side_padding = 1, scrollbar = true },
				documentation = { border = float_border, winhighlight = float_winhighlight, zindex = 1001, scrolloff = 0, col_offset = 0, side_padding = 1, scrollbar = true },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						-- Check if we are in a snippet and jump to the start
						while luasnip.jumpable(-1) do
							luasnip.jump(-1)
						end
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						-- Check if we are in a snippet and jump to the end
						while luasnip.jumpable(1) do
							luasnip.jump(1)
						end
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp", keyword_length = 0 },
				{ name = "luasnip", keyword_length = 0 },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
			},
		})
		-- Set configuration for specific filetype.
		cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
			sources = cmp.config.sources({
				{ name = "vim-dadbod-completion" },
			}, {
				{ name = "buffer" },
			}),
		})

		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
