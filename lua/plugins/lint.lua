return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      solidjs = { 'eslint_d' },
      python = { 'ruff' },
      dockerfile = { 'hadolint' },
      sql = { 'sqlfluff' },
    }
    lint.linters.sqlfluff.args = {
      'lint',
      '--format=json',
      '--dialect=sqlite',
    }
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
