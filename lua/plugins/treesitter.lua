return {
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate sync',
    config = function()
      require('nvim-treesitter').setup{}
      require('nvim-treesitter').install{
        'bash', 'c', 'cpp', 'css', 'dockerfile', 'gdscript', 'gdshader',
        'godot_resource', 'html', 'http', 'javascript', 'json', 'lua',
        'markdown', 'markdown_inline', 'prisma', 'python', 'sql', 'tsx',
        'typescript', 'vim', 'vimdoc', 'yaml',
      }:wait(300000)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
        pattern = {
          'bash', 'c', 'cpp', 'css', 'dockerfile', 'gdscript', 'gdshader',
          'godot_resource', 'html', 'http', 'javascript', 'javascriptreact',
          'json', 'lua', 'markdown', 'prisma', 'python', 'sql',
          'typescript', 'typescriptreact', 'tsx', 'vim', 'yaml',
        },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
