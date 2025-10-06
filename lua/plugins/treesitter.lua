return {
	{
		"nvim-treesitter/nvim-treesitter", 
		branch = 'master', 
		lazy = false, 
		build = ":TSUpdate",
		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = { "c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"rust",
					"cpp",
					"html",
					"css",
					"javascript",
					"typescript",
					"python",
					"tsx",
					"json",
				},
				sync_install = true,
				auto_install = true,
				ignore_install = {},
				highlight = {
					enable = true,

					-- Use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					-- disable = function(lang, buf)
					-- 		local max_filesize = 200 * 1024 -- 100 KB
					-- 		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					-- 		if ok and stats and stats.size > max_filesize then
					-- 				return true
					-- 		end
					-- end,

					additional_vim_regex_highlighting = true,
				},
			}
		end
	}
}
