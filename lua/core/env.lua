-- Environment fixes that must run before any plugin (mason in particular)
-- spawns external processes.
--
-- Mason installs packages by running installers like `npm install` or
-- `unzip <file>`. Those commands are looked up in Neovim's PATH, which is
-- inherited from whatever launched Neovim. When Neovim is started from a
-- GUI launcher (or any process that didn't source nvm), nvm-managed
-- node/npm are missing from PATH and every npm-based mason package fails
-- with: "Could not find executable 'npm' in PATH."
--
-- Fix: extend Neovim's PATH with the directories those tools live in,
-- regardless of how Neovim was launched.

local function add_to_path(dir)
  if dir == '' then
    return
  end
  dir = vim.fs.normalize(dir)
  if vim.uv.fs_stat(dir) and not vim.env.PATH:find(vim.pesc(dir), 1, true) then
    vim.env.PATH = vim.env.PATH .. ':' .. dir
  end
end

-- nvm-managed node/npm: use the newest installed version.
-- NVM_DIR defaults to ~/.config/nvm (and ~/.nvm on older setups).
local nvm_dirs = { vim.env.NVM_DIR or '', '~/.config/nvm', '~/.nvm' }
for _, nvm_dir in ipairs(nvm_dirs) do
  if nvm_dir ~= '' then
    nvm_dir = vim.fs.normalize(nvm_dir)
    local versions_dir = nvm_dir .. '/versions/node'
    local latest_version
    if vim.uv.fs_stat(versions_dir) then
      for name, ty in vim.fs.dir(versions_dir) do
        if ty == 'directory' and name:match '^v%d+%.%d+%.%d+$' then
          if not latest_version or name > latest_version then
            latest_version = name
          end
        end
      end
    end
    if latest_version then
      add_to_path(('%s/versions/node/%s/bin'):format(nvm_dir, latest_version))
      break
    end
  end
end

-- Common user-local bin dirs (pip/pipx/cargo/manual installs).
add_to_path '~/.local/bin'
add_to_path '~/.cargo/bin'

-- Warn once if `unzip` is missing. Mason needs it to install several
-- packages (stylua, deno, clangd, codelldb, ...). It is a system
-- dependency and cannot be installed from within Neovim.
if vim.fn.executable 'unzip' == 0 then
  vim.defer_fn(function()
    vim.notify(
      "Mason: `unzip` was not found in PATH, some packages (stylua, deno, clangd, codelldb, ...) will fail to install.\n"
        .. "Install it with:  sudo pacman -S unzip",
      vim.log.levels.WARN
    )
  end, 500)
end
