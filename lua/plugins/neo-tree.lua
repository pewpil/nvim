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
    -- Projects may provide overrides from their `.nvim.lua` (exrc) via
    -- `vim.g.neotree_project_opts`. This plugin loads eagerly, i.e. before
    -- exrc runs, so the merge with the options below is re-done right after
    -- startup on the first event loop tick (before any user interaction).
    local base_opts = {
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
        window = {
          mappings = {
            ['t'] = function(state)
              local node = state.tree:get_node()
              if node.type ~= 'file' then
                state.commands['toggle_directory'](state)
                return
              end
              local path = vim.fn.fnameescape(node.path)
              vim.cmd('tabnew')
              vim.cmd('e ' .. path)
            end,
            ['<C-v>'] = 'open_vsplit',
          },
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
    require('neo-tree').setup(base_opts)
    vim.defer_fn(function()
      local project_opts = vim.g.neotree_project_opts
      if project_opts ~= nil and next(project_opts) ~= nil then
        require('neo-tree').setup(vim.tbl_deep_extend('force', base_opts, project_opts))
      end
    end, 0)
  end,
}
