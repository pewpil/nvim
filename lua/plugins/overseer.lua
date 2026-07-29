return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      direction = 'bottom',
      min_height = 25,
      max_height = 25,
      default_detail = 1,
    },
    templates = { 'builtin', 'drizzle' },
  },
  config = function(_, opts)
    require('overseer').setup(opts)

    require('overseer').register_template({
      name = 'drizzle-kit push',
      builder = function()
        return {
          cmd = { 'npx' },
          args = { 'drizzle-kit', 'push' },
          name = 'drizzle-kit push',
          cwd = vim.fn.getcwd(),
        }
      end,
    })

    require('overseer').register_template({
      name = 'drizzle-kit generate',
      builder = function()
        return {
          cmd = { 'npx' },
          args = { 'drizzle-kit', 'generate' },
          name = 'drizzle-kit generate',
          cwd = vim.fn.getcwd(),
        }
      end,
    })

    require('overseer').register_template({
      name = 'drizzle-kit migrate',
      builder = function()
        return {
          cmd = { 'npx' },
          args = { 'drizzle-kit', 'migrate' },
          name = 'drizzle-kit migrate',
          cwd = vim.fn.getcwd(),
        }
      end,
    })

    require('overseer').register_template({
      name = 'drizzle-kit studio',
      builder = function()
        return {
          cmd = { 'npx' },
          args = { 'drizzle-kit', 'studio' },
          name = 'drizzle-kit studio',
          cwd = vim.fn.getcwd(),
        }
      end,
    })

    vim.keymap.set('n', '<leader>o', '<cmd>OverseerToggle<cr>', { desc = 'Overseer: Toggle' })
    vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Overseer: Run' })
    vim.keymap.set('n', '<leader>oss', '<cmd>OverseerSaveBundle<cr>', { desc = 'Overseer: Save Session' })
    vim.keymap.set('n', '<leader>osl', '<cmd>OverseerLoadBundle<cr>', { desc = 'Overseer: Load Session' })
  end,
}
