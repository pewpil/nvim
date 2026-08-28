return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('diffview').setup()
    vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview: open' })
    vim.keymap.set('n', '<leader>gD', '<cmd>DiffviewFileHistory<cr>', { desc = 'Diffview: file history' })
    vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<cr>', { desc = 'Diffview: close' })
  end,
}
