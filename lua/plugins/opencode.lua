return {
  'nickjvandyke/opencode.nvim',
  version = '*',
  dependencies = {
    {
      'folke/snacks.nvim',
      opts = {
        input = {}, -- Enhances ask()
        picker = {
          actions = {
            opencode_send = function(...) return require('opencode').snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}
    -- vim.opt.autoread is already enabled globally (core/options.lua)

    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() require('opencode').ask('@this: ') end, { desc = 'Ask OpenCode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>os', function() require('opencode').select() end, { desc = 'OpenCode actions' })
    vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator('@this ') end, { desc = 'Append to OpenCode', expr = true })
    vim.keymap.set('n', 'goo', function() return require('opencode').operator('@this ') .. '_' end, { desc = 'Append line to OpenCode', expr = true })
  end,
}
