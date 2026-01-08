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
    -- Add treesitter to extend our editing power
    'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'dockerfile', 'javascript', 'typescript', 'tsx', 'http', 'json', 'gdscript', 'gdshader', 'godot_resource' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },
      indent = { enable = true, disable = { 'python' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
