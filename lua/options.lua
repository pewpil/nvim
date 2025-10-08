vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.smartindent = true
vim.o.scrolloff = 12
vim.o.mouse = ""

vim.keymap.set("n", "J", function()
	vim.cmd("tabprev")
end, {})
vim.keymap.set("n", "K", function()
	vim.cmd("tabnext")
end, {})
local opts = { silent = true }
vim.keymap.set("n", "<C-j>", ":tabmove -1<CR>", opts)
vim.keymap.set("n", "<C-k>", ":tabmove +1<CR>", opts)
vim.keymap.set("n", ">", ":tabnext<CR>", opts)
vim.keymap.set("n", "<", ":tabprev<CR>", opts)
vim.keymap.set("n", "<A-j>", "<C-w>h", opts)
vim.keymap.set("n", "<A-k>", "<C-w>l", opts)
vim.keymap.set("n", "<A-h>", "<C-w>H", opts)
vim.keymap.set("n", "<A-l>", "<C-w>L", opts)
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
vim.keymap.set("n", "<leader>aq", function()
	vim.cmd("wa")
	vim.cmd("qa!")
end, opts)
vim.keymap.set("n", "<leader>tq", function()
	vim.cmd("tabclose")
end, opts)
vim.keymap.set("n", "<leader>Tt", function()
	vim.cmd("tabnew | terminal")
end, opts)
vim.keymap.set("n", "<leader>tt", function()
	vim.cmd("terminal")
end, opts)

vim.keymap.set("n", "<C-r>l", function()
	local full_path = vim.fn.expand("%:p"):gsub(" ", "\\ ")
	local filename = vim.fn.expand("%:t:r")
	local cwd = vim.fn.getcwd()
	vim.cmd("w")
	vim.cmd("tabnew | terminal")
	--The following function ensures that the text gets typed into the terminal after a delay (100ms) which gives Neovim enough time to open the terminal window
	vim.defer_fn(function()
		--The following functions makes neovim sends string to the buffer which should currently be the terminal
		vim.api.nvim_feedkeys("ag++ " .. full_path .. " -o " .. filename, "n", true)
		vim.api.nvim_feedkeys(" && clear", "n", true)
		vim.api.nvim_feedkeys(" && " .. cwd .. "/" .. filename, "n", true)
		vim.api.nvim_feedkeys(" && echo", "n", true)
		vim.api.nvim_feedkeys("\r", "n", true)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
	end, 50)
end, opts)
