return {
	"github/copilot.vim",
	config = function()
		local opts = { noremap = true, silent = true, desc = "Enable Copilot" }
		vim.keymap.set("n", "<leader>Ce", ":Copilot enable<CR>", opts)
		vim.keymap.set("n", "<leader>Cd", ":Copilot disable<CR>", opts)
		vim.keymap.set(
			"i",
			"<C-J>",
			'copilot#Accept("<CR>")',
			{ expr = true, silent = true, desc = "Accept Copilot suggestion" }
		)

		vim.g.copilot_filetypes = {
			text = true,
			typescript = true,
			javascript = true,
			typescriptreact = true,
			javascriptreact = true,
			python = true,
			lua = true,
			cpp = true,
			c = true,
			java = true,
			rust = true,
			go = true,
			ruby = true,
			markdown = true,
			["*"] = true,
		}

		vim.cmd("Copilot disable")
	end,
}
