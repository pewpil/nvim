return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      mode = 'buffers', -- set to "tabs" to only show tabpages instead
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
}
