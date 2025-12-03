return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'black' },
      -- Use a sub-process to run the formatter
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      solidjs = { 'prettierd' },
      css = { 'prettierd' },
      scss = { 'prettierd' },
      sass = { 'prettierd' },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
