return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			local neotree = require("neo-tree")

			-- neo tree will close if it's open on the current tab, otherwise it will open
			vim.keymap.set("n", "<C-n>", function()
				require("neo-tree.command").execute({ toggle = true })
			end, { desc = "Toggle NeoTree" })

			neotree.setup({
				window = {
					mappings = {
						["<space>"] = "none",
					},
				},
				default_component_configs = {
					indent = {
						with_expanders = true,
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
				},
				-- Other configuration options...
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function()
							-- Set both absolute and relative numbers for the hybrid style,
							-- where the current line shows the absolute number (optional but common for relative numbering).
							vim.opt_local.number = true
							vim.opt_local.relativenumber = true
						end,
					},
				},
			})
		end,
	},
}
