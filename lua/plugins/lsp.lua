return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is required for setup({})` to be called
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- [[ Configure LSP ]]

    -- Set borders for LSP hover and signature help
    local border = {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }
    
    -- Diagnostic config
    vim.diagnostic.config {
      virtual_text = {
        spacing = 4,
        prefix = '●',
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        source = "always",
        border = border,
      },
    }

    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
      callback = function()
        vim.diagnostic.open_float(nil, {
          focus = false,
          scope = "line",
          border = border,
        })
      end,
    })

    -- Global handlers (fallback)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

    -- This function gets run when an LSP connects to a particular buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.name == 'ts_ls' then
          client.server_capabilities.documentFormattingProvider = true
        end

        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper functions to reduce boilerplate
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('gh', function()
          vim.lsp.buf.hover({ border = border })
        end, 'Hover Documentation')
        nmap('<C-k>', function()
          vim.lsp.buf.signature_help({ border = border })
        end, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.keymap.set('n', '<leader>f', function()
          require('conform').format({ async = true, lsp_fallback = true })
        end, { buffer = bufnr, desc = 'Format current buffer with Conform' })
      end,
    })

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before lspconfig setup.
    require('mason').setup()
    require('mason-tool-installer').setup {
      ensure_installed = {
        'prettierd',
        'stylua',
        'eslint_d',
        'black',
        'ruff',
        'hadolint',
        'gdtoolkit',
      },
    }

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    local servers = {
      -- clojure_lsp = {},
      -- emmet_ls = {},
      --โก = {},
      -- haskell = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for this example, we'll just use tsserver
      --
      dockerls = {},
      docker_compose_language_service = {},
      cssls = {
        settings = {
          css = {
            format = {
              spaceAroundSelectorSeparator = true,
            },
          },
          scss = {
            format = {
              spaceAroundSelectorSeparator = true,
            },
          },
        },
      },
      html = {},
      tailwindcss = {},
      -- jsonls = {},
      ts_ls = {
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
          formattingOptions = {
            insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
            insertSpaceBeforeFunctionParenthesis = false,
          },
        },
        settings = {
          javascript = {
            format = {
              enable = true,
              insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
              insertSpaceBeforeFunctionParenthesis = false,
              insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
              insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
              insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
            },
          },
          typescript = {
            format = {
              enable = true,
              insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
              insertSpaceBeforeFunctionParenthesis = false,
              insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
              insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
              insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
            },
          },
        },
      },
      denols = {},
      pylsp = {},
      sqlls = {},
      --
      --

      gdscript = {},

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    local servers_to_install = vim.tbl_filter(function(key)
      return key ~= 'gdscript'
    end, vim.tbl_keys(servers))

    mason_lspconfig.setup {
      ensure_installed = servers_to_install,
      handlers = {
        function(server_name)
          local server_config = {
            capabilities = capabilities,
            settings = servers[server_name],
          }

          if server_name == 'denols' then
            server_config.root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
          end

          -- Merge config and enable
          if vim.lsp.config[server_name] then
             for k, v in pairs(server_config) do
               vim.lsp.config[server_name][k] = v
             end
          else
             vim.lsp.config[server_name] = server_config
          end
          vim.lsp.enable(server_name)
        end,
      },
    }

    -- GDScript setup (not managed by mason)
    vim.lsp.config.gdscript = {
      capabilities = capabilities,
      cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
      root_markers = { 'project.godot', '.git' },
      filetypes = { 'gd', 'gdscript', 'gdscript3' },
    }
    vim.lsp.enable('gdscript')
  end,
}
