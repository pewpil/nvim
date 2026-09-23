return {
  -- Live-rendered markdown preview inside the buffer (Obsidian-style):
  -- headings, tables, checkboxes, callouts (> [!note]), wikilinks, etc.
  -- https://github.com/OXY2DEV/markview.nvim
  'OXY2DEV/markview.nvim',
  ft = 'markdown', -- lazy-load on markdown files
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {},
}
