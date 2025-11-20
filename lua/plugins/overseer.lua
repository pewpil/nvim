return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      direction = 'bottom',
      min_height = 25,
      max_height = 25,
      default_detail = 1,
    },
  },
  config = function(_, opts)
    require('overseer').setup(opts)
    vim.keymap.set('n', '<leader>o', '<cmd>OverseerToggle<cr>', { desc = 'Overseer: Toggle' })
    vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Overseer: Run' })
    vim.keymap.set('n', '<leader>oss', '<cmd>OverseerSaveBundle<cr>', { desc = 'Overseer: Save Session' })
    vim.keymap.set('n', '<leader>osl', '<cmd>OverseerLoadBundle<cr>', { desc = 'Overseer: Load Session' })
  end,
}
