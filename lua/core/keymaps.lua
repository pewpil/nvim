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

-- Copy the diagnostic error message on the current line to clipboard
vim.keymap.set('n', '<leader>de', function()
  local line = vim.fn.line('.') - 1
  local diags = vim.diagnostic.get(0)
  local msgs = {}
  for _, d in ipairs(diags) do
    if d.range and d.range.start.line <= line and d.range["end"].line >= line then
      table.insert(msgs, d.message)
    end
  end
  if #msgs > 0 then
    local text = table.concat(msgs, '\n')
    vim.fn.setreg('+', text)
    vim.notify('Copied diagnostic: ' .. text:sub(1, 80) .. (#text > 80 and '...' or ''), vim.log.levels.INFO)
  else
    vim.notify('No diagnostic on this line', vim.log.levels.WARN)
  end
end, { desc = 'Copy diagnostic message under cursor' })

-- Markdown preview with glow
vim.keymap.set('n', '<leader>mp', function()
  local glow = vim.fn.expand '~/.local/bin/glow'
  local file = vim.fn.expand '%'
  if vim.bo.filetype ~= 'markdown' then
    vim.notify('Not a markdown file', vim.log.levels.WARN)
    return
  end
  if vim.fn.filereadable(glow) == 0 then
    vim.notify('glow not found at ' .. glow, vim.log.levels.ERROR)
    return
  end
  local output = vim.fn.system { glow, '-p', '-s', 'dark', file }
  if vim.v.shell_error ~= 0 then
    vim.notify('glow error:\n' .. output, vim.log.levels.ERROR)
    return
  end
  output = output:gsub('\r', '')
  output = output:gsub('\27%[[%d;]*%a', '')
  local lines = vim.split(output, '\n')
  vim.cmd 'vertical botright new'
  vim.cmd 'vertical resize 80'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.modifiable = false
  vim.bo.syntax = 'glowpreview'
  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true, silent = true, desc = 'Close preview' })
end, { desc = 'Markdown: Preview with glow' })

-- Restart Deno LSP (e.g. after editing deno.json)
vim.keymap.set('n', '<leader>lr', function()
  local clients = vim.lsp.get_clients({ name = 'denols' })
  if #clients == 0 then
    vim.notify('denols is not running', vim.log.levels.WARN)
    return
  end
  for _, client in ipairs(clients) do
    client.stop()
  end
  vim.defer_fn(function()
    local buf = vim.api.nvim_get_current_buf()
    vim.lsp.start(vim.lsp.config.denols, { bufnr = buf })
  end, 100)
end, { desc = 'Restart Deno LSP' })


