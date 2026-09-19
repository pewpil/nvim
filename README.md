# Neovim Configuration for Full-Stack Web Development

This is a Neovim configuration tailored for full-stack web development, with a specific focus on **SolidJS** and **SolidStart**. It is built using **Lua** and managed by the **lazy.nvim** plugin manager.

## Features

*   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **Language Support:** Lua, JavaScript, TypeScript, Python, HTML, CSS, TailwindCSS, SQL, Docker, Godot (GDScript/GDShader), Prisma, Drizzle ORM, Bash, C/C++, JSON, YAML, Markdown, Deno (JS/TS), Vimscript.
*   **Treesitter:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) v3 provides parsers and queries for syntax highlighting (including SQL injection in tagged template literals). Highlighting is enabled natively by Neovim 0.12.
*   **Core Plugins:**
    *   **LSP:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) (with [mason.nvim](https://github.com/williamboman/mason.nvim) for automatic installation, [fidget.nvim](https://github.com/j-hui/fidget.nvim) for LSP progress notifications, and [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) for JSON schema validation). Includes Deno support (`denols`) with config hot-reload on `deno.json`/`deno.jsonc` saves and a `:DenoReload` command. Floating diagnostics on `CursorHold`, rounded float borders.
    *   **DAP:** [nvim-dap](https://github.com/mfussenegger/nvim-dap) with Node.js/TypeScript debug configs for Drizzle/Next.js apps, a Godot debug adapter (port 6006), and debug adapters installed via [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) (`delve`, `js-debug-adapter`, `python`, `codelldb`).
    *   **Godot:** [vim-godot](https://github.com/habamax/vim-godot) for Godot Editor integration.
    *   **Treesitter:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting and parsing.
    *   **Fuzzy Finder:** [Telescope](https://github.com/nvim-telescope/telescope.nvim).
    *   **Git Integration:** [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
    *   **Debugger:** [nvim-dap](https://github.com/mfussenegger/nvim-dap) with UI [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
    *   **Commenting:** [Comment.nvim](https://github.com/numToStr/Comment.nvim) (with context-aware support for JSX/TSX via [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)).
    *   **HTTP Client:** [rest.nvim](https://github.com/rest-nvim/rest.nvim) and [kulala.nvim](https://github.com/mistweaverco/kulala.nvim) (supports `.http` and `.rest` files; `.rest` is mapped to the `http` filetype).
    *   **AI Assistant:** [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) (with [snacks.nvim](https://github.com/folke/snacks.nvim) picker/input) for OpenCode integration.
    *   **Diff Viewer:** [diffview.nvim](https://github.com/sindrets/diffview.nvim).
    *   **Database:** [vim-dadbod](https://github.com/tpope/vim-dadbod) with [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) and [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion); saved queries live in `db_ui_queries/` under this config directory.
    *   **Indent Guides:** [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
    *   **Development Utilities:** [neodev.nvim](https://github.com/folke/neodev.nvim) for Neovim Lua development.
*   **UI/UX:**
    *   **Statusline:** [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
    *   **Bufferline:** [bufferline.nvim](https://github.com/akinsho/bufferline.nvim).
    *   **File Explorer:** [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim).
    *   **Colorscheme:** [Catppuccin](https://github.com/catppuccin/nvim).
    *   **Icons:** [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons).
*   **Performance:** Lazy loading for fast startup times.
*   **Linting/Formatting:**
    *   **Formatting:** [conform.nvim](https://github.com/stevearc/conform.nvim).
    *   **Linting:** [nvim-lint](https://github.com/mfussenegger/nvim-lint).
    *   **Tools:**
        *   **Formatters:** `prettierd` (JS/TS/CSS/HTML/Solid), `stylua` (Lua), `black` (Python), `clang-format` (C/C++), `sql_formatter` (SQL, custom config in `sql-formatter.json`), plus a `remove_space` `sed` pass that removes the space in `function (` for JS/TS.
        *   **Linters:** `eslint_d` (JS/TS/Solid), `ruff` (Python), `hadolint` (Docker), `sqlfluff` (SQL, SQLite dialect).
    *   **Format on Save:** enabled (`conform.nvim`, LSP fallback; there is no manual format keymap).
*   **Build Tools:** [overseer.nvim](https://github.com/stevearc/overseer.nvim) for task running.
*   **Project-specific Config:** `exrc` is enabled — Neovim loads `.nvim.lua`/`.nvimrc`/`.exrc` from the project root (see [Project-local overrides](#project-local-overrides)).
*   **Autocompletion & Snippets:**
    *   [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for completion.
    *   [LuaSnip](https://github.com/L3MON4D3/LuaSnip) for snippet engine.
    *   **Custom SolidJS Snippets:** Comprehensive snippets for SolidJS (signals, effects, components, etc.) located in `snippets/`.
    *   **JSX/TSX Enhancements:** Extended `javascriptreact` and `typescriptreact` to include HTML snippets for better autocompletion.

## Structure

The configuration is organized into the following directories:

*   `init.lua`: The entry point. It sets up `lazy.nvim` and loads the rest of the configuration.
*   `lua/core/`: Core Neovim settings (`options.lua`) and global keymaps (`keymaps.lua`).
*   `lua/plugins/`: Plugin configurations. Each file represents a plugin or a related group of plugins.
*   `ftplugin/`: Filetype-specific configurations (`sass.lua`, `scss.lua`, `sql.lua`).
*   `snippets/`: Custom VSCode-style snippets for SolidJS and JSX.

## Installation

1.  Clone this repository into your Neovim configuration directory (usually `~/.config/nvim`).
2.  Start Neovim. `lazy.nvim` will automatically install all the plugins.
3.  **Mason** will automatically install the configured LSPs, linters, and formatters.
    *   You can run `:Mason` to see the status of installed tools.

## Key-bindings

The leader key is set to `<Space>` (`<Space>` itself is unmapped with `<Nop>` in normal and visual modes).

### Editor & Navigation

*   `j`/`k`: Move wrapped lines naturally.
*   `<leader>x`: Save all and quit (`:wa | qa`).
*   `<leader>q`: Quit current window (`:quit`).
*   `<leader>r`: Refresh all buffers from disk (`:checktime`, pairs with `autoread`).
*   `<leader>de`: Copy diagnostic message(s) on the current line to the clipboard.
*   `<leader>t`: Open terminal in current buffer.
*   `<leader>T`: Open terminal in new tab.
*   `<leader>v`: Open terminal in vertical split.
*   `<C-\><C-n>` (in terminal): Exit terminal mode (default Neovim behavior).

### Window Management

*   `<C-h/j/k/l>`: Navigate between splits (`<C-j/k/l>` also work in terminal mode).
*   `<leader>h`: Move split left.
*   `<leader>l`: Move split right.
*   `<leader>k`: Move split up.
*   `<leader>j`: Move split down.

### File Explorer (Neo-tree)

*   `<leader>e`: Toggle file explorer (shows hidden/dotfiles except `.git`, `node_modules`, etc).
*   `<CR>`: Open file or folder.
*   `t`: Open in new tab (clean tab, no terminal duplication).
*   `<C-v>`: Open in vertical split.
*   `a`: Add file/directory.
*   `d`: Delete.
*   `r`: Rename.
*   `c`: Copy.
*   `x`: Cut.
*   `p`: Paste.
*   `o`: "Order by" menu prefix (neo-tree default; it does **not** open files).
*   Apart from `t` and `<C-v>`, the mappings inside the tree window are neo-tree defaults, not set by this config.
*   Projects can override the whole setup (filters, mappings, …) via `vim.g.neotree_project_opts` in their `.nvim.lua` (see [Project-local overrides](#project-local-overrides)).

### Telescope (Fuzzy Finder)

*   `<leader>?`: Find recently opened files.
*   `<leader><space>`: Find existing buffers.
*   `<leader>/`: Fuzzily search in current buffer.
*   `<leader>gf`: Search Git files.
*   `<leader>sf`: Search files (also shows allowlisted directories like `.opencode/`).
*   `<leader>sh`: Search help tags.
*   `<leader>sw`: Search current word (grep).
*   `<leader>sg`: Live grep search.
*   `<leader>sd`: Search diagnostics.
*   **`<C-f>`** (insert mode): Scroll preview down.
*   **`<C-b>`** (insert mode): Scroll preview up.
*   `<C-u>` / `<C-d>` are disabled in the Telescope prompt's insert mode (freed for other uses).
*   Preview windows wrap long lines.
*   `<leader>sf` includes allowlisted hidden directories. The default list (`{ '.opencode/' }`) can be overridden per project via `vim.g.telescope_files_allowlisted_dirs` (see [Project-local overrides](#project-local-overrides)).

### Tabs (Bufferline)

*   `J`: Previous tab.
*   `K`: Next tab.
*   `<S-h>`: Move tab left.
*   `<S-l>`: Move tab right.
*   `Q`: Close current tab.

### LSP (Language Server Protocol)

*   `gd`: Go to definition (opens in new tab).
*   `gv`: Go to definition (opens in vertical split).
*   `gr`: Go to references.
*   `gI`: Go to implementation.
*   `gD`: Go to declaration.
*   `<leader>D`: Type definition.
*   `<leader>rn`: Rename symbol.
*   `<leader>ca`: Code action.
*   Formatting happens on save (`conform.nvim`); no manual format keymap is bound.
*   `gh`: Hover documentation.
*   `<C-k>`: Signature help (buffer-local; overrides the global `<C-k>` split navigation in LSP buffers).
*   `<leader>lr`: Restart the Deno LSP (`denols`).
*   `<leader>ds`: Document symbols.
*   `<leader>ws`: Workspace symbols.
*   `<leader>wa`: Add workspace folder.
*   `<leader>wr`: Remove workspace folder.
*   `<leader>wl`: List workspace folders.

### Debugger (nvim-dap)

*   `<F5>`: Start/Continue.
*   `<F1>`: Step into.
*   `<F2>`: Step over.
*   `<F3>`: Step out.
*   `<F7>`: Toggle DAP UI (see last session result).
*   `<leader>b`: Toggle breakpoint.
*   `<leader>B`: Set conditional breakpoint.
*   Godot projects: `F5` launches the current scene via the Godot debug adapter (requires the Godot Editor to be running with the debug server on port 6006).

### Deno

*   `<leader>lr`: Restart the Deno LSP.
*   `:DenoReload`: Restart the Deno LSP command.
*   `deno.json`/`deno.jsonc` changes are picked up automatically on write.

### Diff Viewer (Diffview)

*   `<leader>gd`: Open Diffview.
*   `<leader>gD`: Open file history.
*   `<leader>gq`: Close Diffview.

### AI Assistant (OpenCode)

*   `<leader>oa`: Ask OpenCode with `@this:` (also in visual mode).
*   `<leader>os`: Open OpenCode actions menu (also in visual mode).
*   `go`: Operator — append motion/textobject to OpenCode.
*   `goo`: Append the current line to OpenCode.
*   In the snacks picker: `<A-a>` sends the selected entry to OpenCode.

### Database (vim-dadbod)

*   SQL filetypes (`sql`, `mysql`, `plsql`) get completion from the active database connection via `vim-dadbod-completion`.
*   Saved queries are stored in `~/.config/nvim/db_ui_queries/` (`:DBUI` to open the UI).

### Git (gitsigns)

*   `<leader>gn`: Next hunk.
*   `<leader>gp`: Previous hunk.
*   `<leader>gv`: Preview hunk.
*   `<leader>gb`: Blame line.

### Task Runner (Overseer)

*   `<leader>o`: Toggle Overseer window.
*   `<leader>or`: Run a task (includes drizzle-kit push, generate, migrate, studio).
*   `<leader>oss`: Save session.
*   `<leader>osl`: Load session.
*   Note: because OpenCode shares the `<leader>o` prefix (`<leader>oa`, `<leader>os`), pressing `<leader>o` (and `<leader>os`, which prefixes `<leader>oss`/`<leader>osl`) waits `timeoutlen` (1s) before firing.

### Autocompletion (nvim-cmp) & Snippets (LuaSnip)

*   `<C-n>` / `<Tab>`: Select next item.
*   `<C-p>` / `<S-Tab>`: Select previous item.
*   `<C-b>`: Scroll documentation up.
*   `<C-f>`: Scroll documentation down.
*   `<C-Space>`: Trigger completion manually.
*   `<C-e>`: Abort completion.
*   `<CR>`: Confirm completion.
*   `<Down>` / `<Up>`: Select next/previous item (nvim-cmp preset defaults).
*   `<C-y>`: Confirm completion (nvim-cmp preset default).
*   **`<C-l>`**: Jump forward through snippet placeholders (cycles back to start).
*   **`<C-h>`**: Jump backward through snippet placeholders (cycles back to end).

### Markdown (glow)

*   `<leader>mp`: Open current markdown file in a vertical split with glow TUI rendering (requires `glow` at `~/.local/bin/glow`; `q` closes the preview).

### Comments (Comment.nvim)

*   `gc`: Toggle comment (linewise operator).
*   `gb`: Toggle comment (blockwise operator).
*   `gcc` / `gbc`: Toggle comment on the current line (Comment.nvim defaults).
*   `gcO` / `gco` / `gcA`: Insert comment above/below/at end of line (Comment.nvim "extra" defaults).

### HTTP Client (rest.nvim / kulala.nvim)

*   `<leader>rs`: Run request (Kulala).
*   `<leader>rt`: Toggle headers/body (Kulala).
*   `<leader>rp`: Jump to previous request (Kulala).
*   `<leader>rn`: Jump to next request (Kulala). Note: in LSP-attached buffers this is shadowed by the buffer-local LSP rename mapping.
*   `<leader>rc`: Copy as cURL (Kulala).
*   `<leader>re`: Set environment (Kulala).
*   `<leader>rr`: Run request under cursor (Rest.nvim).
*   `<leader>rl`: Re-run last request (Rest.nvim).

## Project-local overrides

`exrc` is enabled (`vim.opt.exrc = true` in `lua/core/options.lua`), so Neovim reads a project-local `.nvim.lua`, `.nvimrc`, or `.exrc` from the working directory. Keep such files out of version control when they contain machine-specific code; only source them from trusted projects (no `secure` option is set).

Two override points are provided for projects:

*   `vim.g.neotree_project_opts`: a table merged (deep) into the neo-tree setup shortly after startup. Example:

    ```lua
    vim.g.neotree_project_opts = {
      filesystem = {
        filtered_items = { hide_by_name = { '.git', 'node_modules', 'dist' } },
      },
    }
    ```

*   `vim.g.telescope_files_allowlisted_dirs`: list read when `<leader>sf` is pressed (after exrc has run). Each entry is either a directory string (lists hidden files) or a table `{ dir = 'path', no_ignore = true }` to also list gitignored files (excluding any `.git`). Default: `{ '.opencode/' }`. Example:

    ```lua
    vim.g.telescope_files_allowlisted_dirs = { 'public/', { dir = 'dist/', no_ignore = true } }
    ```
