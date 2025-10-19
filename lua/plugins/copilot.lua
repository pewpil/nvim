return {
	"github/copilot.vim",
	config = function ()
		local opts = { noremap = true, silent = true, desc = "Enable Copilot" }
		vim.keymap.set("n", "<leader>Ce", ":Copilot enable<CR>", opts)
		vim.keymap.set("n", "<leader>Cd", ":Copilot disable<CR>", opts)
	end
}
