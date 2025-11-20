return {
  -- Adds git related signs to the gutter, as well as utilities for managing git repositories
  'lewis6991/gitsigns.nvim',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
    vim.keymap.set('n', '<leader>gn', ':Gitsigns next_hunk<CR>', { desc = 'Git: Next Hunk' })
    vim.keymap.set('n', '<leader>gp', ':Gitsigns prev_hunk<CR>', { desc = 'Git: Previous Hunk' })
    vim.keymap.set('n', '<leader>gv', ':Gitsigns preview_hunk<CR>', { desc = 'Git: Preview Hunk' })
    vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'Git: Blame Line' })
  end,
}
