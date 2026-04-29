return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',
    'kristijanhusak/vim-dadbod-completion',
  },
  config = function()
    -- Set up any configuration for Dadbod or Dadbod UI if needed
    vim.g.db_ui_save_location = vim.fn.stdpath('config') .. '/db_ui_queries'
  end,
}
