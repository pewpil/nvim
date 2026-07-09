-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Save all and quit
vim.keymap.set('n', '<leader>x', '<cmd>wa | qa<CR>', { desc = 'Save all and quit' })

-- Terminal
vim.keymap.set('n', '<leader>t', '<cmd>terminal<CR>', { desc = 'Open terminal in current buffer' })
vim.keymap.set('n', '<leader>T', '<cmd>tabnew | terminal<CR>', { desc = 'Open terminal in new tab' })
vim.keymap.set('n', '<leader>v', '<cmd>vsplit | terminal<CR>', { desc = 'Open terminal in vertical split' })
-- Navigate between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower split' })

vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Go to left split' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Go to right split' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Go to upper split' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Go to lower split' })

-- Move current split
vim.keymap.set('n', '<leader>h', '<C-w>H', { desc = 'Move split left' })
vim.keymap.set('n', '<leader>l', '<C-w>L', { desc = 'Move split right' })
vim.keymap.set('n', '<leader>k', '<C-w>K', { desc = 'Move split up' })
vim.keymap.set('n', '<leader>j', '<C-w>J', { desc = 'Move split down' })

-- Refresh all buffers from disk
vim.keymap.set('n', '<leader>r', '<cmd>checktime<CR>', { desc = 'Refresh all buffers from disk' })

-- Quick quit current window
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>', { desc = 'Quit current window' })
