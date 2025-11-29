return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          auto_trigger = false,
          keymap = {
            accept = '<C-l>',
            dismiss = '<C-h>',
          },
        },
      }
      vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = 'Copilot Enable' })
      vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = 'Copilot Disable' })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
