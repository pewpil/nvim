return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      mode = 'tabs', -- set to "tabs" to only show tabpages instead
      -- separator_style = 'slant',
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local icon = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
          s = s .. n .. icon
        end
        return s
      end,
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    vim.keymap.set('n', 'J', '<cmd>tabprevious<CR>', { silent = true, desc = 'Previous tab' })
    vim.keymap.set('n', 'K', '<cmd>tabnext<CR>', { silent = true, desc = 'Next tab' })
    vim.keymap.set('n', 'Q', '<cmd>tabclose<CR>', { silent = true, desc = 'Close current tab' })
  end,
}
