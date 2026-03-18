return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'black' },
      javascript = { 'prettierd', 'lsp' },
      typescript = { 'prettierd', 'lsp' },
      javascriptreact = { 'prettierd', 'lsp' },
      typescriptreact = { 'prettierd', 'lsp' },
      solidjs = { 'prettierd', 'lsp' },
      -- Use a sub-process to run the formatter
      css = { 'prettierd' },
      scss = { 'prettierd' },
      sass = { 'prettierd' },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 2000,
      lsp_format = 'fallback',
    },
  },
}
