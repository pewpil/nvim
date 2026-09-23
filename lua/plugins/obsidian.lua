-- Build the workspace list at startup time:
--  - 'auris': the main vault, always available.
--  - 'cwd': if Neovim was launched inside a vault (an `.obsidian` folder exists
--    in the cwd or any ancestor), make that vault available too, so the whole
--    plugin (links, backlinks, `:Obsidian open`, ...) works no matter which
--    vault directory Neovim was started in.
local workspaces = {
  {
    name = 'auris',
    path = '~/Projects/auris',
  },
}

local cwd_vault = vim.fs.find('.obsidian', { upward = true, path = vim.fn.getcwd() })[1]
if cwd_vault then
  local root = vim.fs.dirname(cwd_vault)
  -- Skip if it's the same vault as an existing workspace (e.g. launched
  -- inside the auris vault).
  local known = false
  for _, ws in ipairs(workspaces) do
    if vim.fs.normalize(ws.path) == root then
      known = true
      break
    end
  end
  if not known then
    workspaces[#workspaces + 1] = { name = 'cwd', path = root }
  end
end

-- Sync the Neovim cursor line to the Obsidian app. Requires the "Advanced URI"
-- community plugin installed inside Obsidian (the obsidian://advanced-uri
-- scheme is registered by that plugin, not by core Obsidian).
local function toggle_scroll_sync()
  if vim.g.obsidian_scroll_sync then
    vim.g.obsidian_scroll_sync = false
    pcall(vim.api.nvim_del_augroup_by_name, 'obsidian_scroll_sync')
    vim.notify('Obsidian scroll sync OFF')
    return
  end

  vim.g.obsidian_scroll_sync = true
  local group = vim.api.nvim_create_augroup('obsidian_scroll_sync', { clear = true })
  -- CursorHold fires once per 'updatetime' after the cursor stops moving, so
  -- Obsidian follows to the line you paused on, without spamming on every move.
  vim.api.nvim_create_autocmd('CursorHold', {
    group = group,
    pattern = '*',
    callback = function()
      if vim.g.obsidian_scroll_sync and vim.bo.filetype == 'markdown' and vim.b.obsidian_buffer then
        vim.cmd 'Obsidian open'
      end
    end,
  })
  vim.notify('Obsidian scroll sync ON: Obsidian jumps to the cursor line whenever you pause')
end

return {
  -- Obsidian vault integration: maintained community fork of epwalsh/obsidian.nvim
  -- Docs: `:Obsidian help`, `:checkhealth obsidian`
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release
  lazy = true,
  ft = 'markdown',
  cmd = 'Obsidian',
  keys = {
    { '<leader>O', '<cmd>Obsidian open<CR>', desc = 'Obsidian: open note at cursor line' },
    { '<leader>OA', toggle_scroll_sync, desc = 'Obsidian: toggle auto scroll-sync' },
  },
  opts = {
    legacy_commands = false, -- single `:Obsidian` entry command (removed in 4.0.0 otherwise)
    workspaces = workspaces,
    picker = {
      name = 'telescope.nvim',
    },
    open = {
      -- Jump to the current cursor line in Obsidian (via the Advanced URI
      -- plugin in Obsidian) instead of just opening the note.
      use_advanced_uri = true,
    },
    -- Disable obsidian.nvim's own buffer decorations: markview.nvim handles
    -- the in-buffer rendering; also avoids the conceallevel>=2 warning.
    ui = {
      enable = false,
    },
  },
}
