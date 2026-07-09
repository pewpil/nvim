return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- If you want icons for file types, you can follow these instructions:
    -- https://github.com/nvim-tree/nvim-web-devicons#usage
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file explorer' })
    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            '.git',
            '.DS_Store',
            'thumbs.db',
            'node_modules',
            '__pycache__',
          },
        },
        keys = {
          ['t'] = 'open_in_tab',
        },
      },
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            vim.wo.number = true
            vim.wo.relativenumber = true
          end,
        },
      },
    }
  end,
}
