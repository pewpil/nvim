return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = { -- :h catppuccin-options
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = true,
    show_end_of_buffer = false, -- show ~ on the ending of the buffer
    term_colors = true,
    no_italic = false,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        inline = false,
      },
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      lsp_trouble = true,
      dashboard = true,
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      mini = {
        enabled = false,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      barbar = true,
      bufferline = true,
      markdown = true,
      neotree = true,
      overseer = true,
      beacon = false,
      inc_rename = false,
      leap = true,
      fern = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      toggleterm = {
        enabled = true,
        background = true,
      },
      harpoon = true,
      notify = true,
      telekasten = true,
      symbols_outline = true,
      multicursors = true,
      nvim_tree = true,
      navic = {
        enabled = true,
        custom_icons = false,
      },
      hop = true,
      cursoredit = true,
      sandwich = true,
      illuminate = true,
      fidget = true,
    },
    color_filter = nil, -- simple function for filtering a color (e.g. `function(rgb) return rgb end`)
    highlight_overrides = {
      all = {
        -- you can override any highlight group with a highlight group name
        -- must use a catppuccin color here (e.g. `catppuccin.colors.mocha.mauve`)
        -- or use a hex color (e.g. `#ffffff`)
        -- Bg = { fg = catppuccin.colors.mocha.red, bg = "#ff0000" },
      },
      latte = {},
      frappe = {},
      macchiato = {},
      mocha = {},
    },
    custom_highlights = {},
    integrations_enabled = true,
    compile = {
      enabled = false,
      path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
  },
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      background = { dark = 'mocha' },
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        telescope = {
          enabled = true,
        },
        mini = {
          enabled = true,
        },
      },
      custom_highlights = function(colors)
        return {
          TelescopeBorder = { bg = "NONE", fg = colors.surface1 },
          TelescopePromptBorder = { bg = "NONE", fg = colors.surface1 },
          TelescopeResultsBorder = { bg = "NONE", fg = colors.surface1 },
          TelescopePreviewBorder = { bg = "NONE", fg = colors.surface1 },
          TelescopeNormal = { bg = "NONE" },
          TelescopePromptNormal = { bg = "NONE" },
          TelescopeResultsNormal = { bg = "NONE" },
          TelescopePreviewNormal = { bg = "NONE" },
          TelescopeTitle = { bg = "NONE", fg = colors.surface1 },
          TelescopePromptTitle = { bg = "NONE", fg = colors.surface1 },
          TelescopeResultsTitle = { bg = "NONE", fg = colors.surface1 },
          TelescopePreviewTitle = { bg = "NONE", fg = colors.surface1 },
          CmpPmenuBorder = { bg = "NONE", fg = colors.surface1 },
          CmpDocBorder = { bg = "NONE", fg = colors.surface1 },
        }
      end,
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
