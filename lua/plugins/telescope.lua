return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup`
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-f>'] = require('telescope.actions').preview_scrolling_down,
            ['<C-b>'] = require('telescope.actions').preview_scrolling_up,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Telescope hardcodes `wrap = false` on its preview window, so re-enable
    -- it after the previewer loads (fires post-load, targeting the preview win).
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TelescopePreviewerLoaded',
      callback = function()
        vim.wo.wrap = true
      end,
    })

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require('telescope.builtin')

    -- Directories that should appear in fuzzy finding even if hidden/dotfiles.
    -- Each entry is a directory string (also lists hidden files), or a table
    -- `{ dir = 'path', no_ignore = true }` to additionally list gitignored
    -- files (excluding any `.git`). Projects may override this list from their
    -- `.nvim.lua` (exrc) via `vim.g.telescope_files_allowlisted_dirs`; it is
    -- read when `<leader>sf` is pressed, i.e. after exrc has run.
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', function()
      local allowlisted_dirs = vim.g.telescope_files_allowlisted_dirs or { '.opencode/' }
      local search_parts = { 'rg --files --color never .' }
      for _, entry in ipairs(allowlisted_dirs) do
        local dir, no_ignore = entry, false
        if type(entry) == 'table' then
          dir, no_ignore = entry.dir, entry.no_ignore
        end
        -- Guard: a table entry without `dir` (e.g. `{ no_ignore = true }`)
        -- would crash the format below; fall back to the current directory.
        if type(dir) ~= 'string' or dir == '' then
          dir = '.'
        end
        local flags = no_ignore and ' --no-ignore --glob "!.git"' or ''
        table.insert(
          search_parts,
          ('rg --files --color never --hidden%s %s 2>/dev/null'):format(flags, dir)
        )
      end
      builtin.find_files({
        find_command = { 'sh', '-c', table.concat(search_parts, ' ; ') .. ' || true' },
      })
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  end,
}
