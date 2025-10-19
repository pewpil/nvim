return {
	"brianhuster/live-preview.nvim",
	config = function ()
		vim.keymap.set("n", "<leader>lps", ":LivePreview start<CR>", {silent = true})
		vim.keymap.set("n", "<leader>lpS", ":LivePreview stop<CR>", {silent = true})
	end
}
