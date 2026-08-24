local function read_comm(pid)
  local ok, lines = pcall(vim.fn.readfile, '/proc/' .. pid .. '/comm', '', 1)
  if not ok or #lines == 0 then return nil end
  local comm = lines[1]:gsub('%s+$', '')
  return comm ~= '' and comm or nil
end

local function proc_stat_fields(pid)
  local ok, lines = pcall(vim.fn.readfile, '/proc/' .. pid .. '/stat', '', 1)
  if not ok or #lines == 0 then return nil end
  local line = lines[1]
  local close = line:find(')', 1, true)
  if not close then return nil end
  local rest = {}
  for w in line:sub(close + 1):gmatch '%S+' do
    rest[#rest + 1] = w
  end
  return {
    pgrp = tonumber(rest[3]),
    tpgid = tonumber(rest[6]),
  }
end

local function scan_pgrp(target)
  local entries = pcall(vim.fn.readdir, '/proc')
  if not entries then return nil end
  for _, e in ipairs(entries) do
    if e:match '^%d+$' then
      local f = proc_stat_fields(e)
      if f and f.pgrp == target then
        local name = read_comm(e)
        if name then return name end
      end
    end
  end
end

-- Returns (cwd, foreground_program) for a terminal shell pid.
local function proc_foreground(pid)
  if not pid then return nil end
  local cwd = vim.uv.fs_realpath('/proc/' .. pid .. '/cwd')
  local f = proc_stat_fields(pid)
  if not f then return cwd, nil end
  local name
  if f.tpgid and f.pgrp and f.tpgid == f.pgrp then
    name = read_comm(pid)
  elseif f.tpgid and f.tpgid > 0 then
    name = read_comm(f.tpgid) or scan_pgrp(f.tpgid)
  end
  return cwd, name
end

local function terminal_tab_names()
  local terms = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local path = vim.api.nvim_buf_get_name(buf)
    local cwd, pid, cmd = path:match '^term://(.*)//(%d+):(.*)$'
    if cwd then
      local real_cwd, prog = proc_foreground(pid)
      if not real_cwd then real_cwd = cwd end
      if not prog then
        local first = (cmd or ''):match '%S+'
        prog = first and first:match '[^/]+$' or ''
      end
      local parts = {}
      for p in real_cwd:gmatch '[^/]+' do
        parts[#parts + 1] = p
      end
      terms[#terms + 1] = { buf = buf, parts = parts, prog = prog }
    end
  end

  local nvim_root = {}
  for p in vim.fn.getcwd():gmatch '[^/]+' do
    nvim_root[#nvim_root + 1] = p
  end

  local names = {}
  for _, a in ipairs(terms) do
    local same = 0
    for _, b in ipairs(terms) do
      if b ~= a and b.prog == a.prog then
        local d = 0
        while d < #a.parts and d < #b.parts and a.parts[#a.parts - d] == b.parts[#b.parts - d] do
          d = d + 1
        end
        if d > same then same = d end
      end
    end

    local depth = same + 1
    local cap = #a.parts
    if #nvim_root > 0 and #a.parts >= #nvim_root then
      local under = true
      for i = 1, #nvim_root do
        if a.parts[i] ~= nvim_root[i] then
          under = false
          break
        end
      end
      if under then cap = #a.parts - #nvim_root + 1 end
    end
    depth = math.min(depth, cap)

    names[a.buf] = {
      cwd = table.concat(a.parts, '/', #a.parts - depth + 1, #a.parts),
      prog = a.prog or '',
    }
  end
  return names
end

local function term_tab_name(bufnr)
  local info = terminal_tab_names()[bufnr]
  if not info or info.cwd == '' then return nil end
  local prog_s = info.prog ~= '' and (' [' .. info.prog .. ']') or ''
  local max = 30
  if vim.fn.strdisplaywidth(info.cwd .. prog_s) <= max then
    return info.cwd .. prog_s
  end
  local budget = max - vim.fn.strdisplaywidth(prog_s) - 3
  if budget < 1 then return '.../' .. prog_s end
  return '.../' .. info.cwd:sub(-budget) .. prog_s
end

local function has_term_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(buf):match '^term://' then return true end
  end
  return false
end

-- bufferline-style disambiguation for regular files: basename, with parent
-- directories added when multiple tabs share the same basename.
local function file_tab_names()
  local names = {}
  local tabs = {}
  local by_base = {}
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local path = vim.api.nvim_buf_get_name(buf)
    if path ~= '' and not path:match '^term://' then
      local parts = {}
      for p in path:gmatch '[^/]+' do
        parts[#parts + 1] = p
      end
      local base = parts[#parts]
      tabs[#tabs + 1] = { buf = buf, parts = parts, base = base }
      by_base[base] = (by_base[base] or 0) + 1
    end
  end

  for _, t in ipairs(tabs) do
    if by_base[t.base] == 1 then
      names[t.buf] = t.base
    else
      local same = 0
      for _, o in ipairs(tabs) do
        if o ~= t and o.base == t.base then
          local d = 0
          while d < #t.parts - 1 and d < #o.parts - 1 and t.parts[#t.parts - d] == o.parts[#o.parts - d] do
            d = d + 1
          end
          if d > same then same = d end
        end
      end
      local depth = math.min(same + 1, #t.parts)
      names[t.buf] = table.concat(t.parts, '/', #t.parts - depth + 1, #t.parts)
    end
  end
  return names
end

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      mode = 'tabs', -- set to "tabs" to only show tabpages instead
      -- separator_style = 'slant',
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local icon = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
          s = s .. n .. icon
        end
        return s
      end,
      show_duplicate_prefix = false,
      truncate_names = false,
      name_formatter = function(ctx)
        local ok, name = pcall(function()
          if (ctx.path or ''):match '^term://' then
            return term_tab_name(ctx.bufnr) or ctx.name
          end
          return file_tab_names()[ctx.bufnr] or ctx.name
        end)
        if ok then return name end
        return ctx.name
      end,
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    vim.keymap.set('n', 'J', '<cmd>tabprevious<CR>', { silent = true, desc = 'Previous tab' })
    vim.keymap.set('n', 'K', '<cmd>tabnext<CR>', { silent = true, desc = 'Next tab' })
    vim.keymap.set('n', 'Q', '<cmd>tabclose<CR>', { silent = true, desc = 'Close current tab' })
    vim.keymap.set('n', '<S-h>', '<cmd>tabmove -1<CR>', { silent = true, desc = 'Move tab left' })
    vim.keymap.set('n', '<S-l>', '<cmd>tabmove +1<CR>', { silent = true, desc = 'Move tab right' })

    local timer = vim.uv.new_timer()
    timer:start(2000, 2000, vim.schedule_wrap(function()
      if has_term_buf() then
        pcall(require('bufferline').refresh)
      end
    end))
  end,
}
