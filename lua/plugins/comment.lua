return {
  'numToStr/Comment.nvim',
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = { enable_autocmd = false },
    },
  },
  config = function()
    local ts_pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    require('Comment').setup({
      pre_hook = function(ctx)
        local ok, parser = pcall(vim.treesitter.get_parser, ctx.buf)
        if ok and parser then
          return ts_pre_hook(ctx)
        end
      end,
    })
  end,
  lazy = false,
}