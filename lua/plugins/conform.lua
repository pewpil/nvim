return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'black' },
      javascript = { 'prettierd', 'remove_space' },
      typescript = { 'prettierd', 'remove_space' },
      javascriptreact = { 'prettierd', 'remove_space' },
      typescriptreact = { 'prettierd', 'remove_space' },
      solidjs = { 'prettierd', 'remove_space' },
      -- Use a sub-process to run the formatter
      css = { 'prettierd' },
      scss = { 'prettierd' },
      sass = { 'prettierd' },
    },
    formatters = {
      remove_space = {
        command = 'sed',
        args = { '-E', 's/function \\(/function(/g' },
        stdin = true,
      },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 2000,
      lsp_format = 'fallback',
    },
  },
}
