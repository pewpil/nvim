return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    keys = {
      {
        '<leader>ct',
        function()
          require('copilot.suggestion').toggle_auto_trigger()
          print('Copilot suggestions toggled')
        end,
        desc = 'Copilot Toggle',
      },
    },
    config = function()
      require('copilot').setup {
        filetypes = { ["*"] = true },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = '<C-j>',
            dismiss = '<C-k>',
          },
        },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
