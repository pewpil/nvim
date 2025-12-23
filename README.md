# Neovim Configuration for Full-Stack Web Development

This is a Neovim configuration tailored for full-stack web development, with a specific focus on **SolidJS** and **SolidStart**. It is built using **Lua** and managed by the **lazy.nvim** plugin manager.

## Features

*   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **Language Support:** Lua, JavaScript, TypeScript, Python, HTML, CSS, TailwindCSS, SQL, Docker.
*   **Core Plugins:**
    *   **LSP:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) (with [mason.nvim](https://github.com/williamboman/mason.nvim) for automatic installation).
    *   **Treesitter:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting and parsing.
    *   **Fuzzy Finder:** [Telescope](https://github.com/nvim-telescope/telescope.nvim).
    *   **Git Integration:** [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
    *   **Debugger:** [nvim-dap](https://github.com/mfussenegger/nvim-dap) with UI [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
    *   **Commenting:** [Comment.nvim](https://github.com/numToStr/Comment.nvim).
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
        *   **Formatters:** `prettierd` (JS/TS/CSS/HTML/Solid), `stylua` (Lua), `black` (Python).
        *   **Linters:** `eslint_d` (JS/TS/Solid), `ruff` (Python), `hadolint` (Docker).
*   **Build Tools:** [overseer.nvim](https://github.com/stevearc/overseer.nvim) for task running.
*   **Autocompletion:**
    *   [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with snippets (LuaSnip).
    *   [Copilot](https://github.com/zbirenbaum/copilot.lua).

## Structure

The configuration is organized into the following directories:

*   `init.lua`: The entry point. It sets up `lazy.nvim` and loads the rest of the configuration.
*   `lua/core/`: Core Neovim settings (`options.lua`) and global keymaps (`keymaps.lua`).
*   `lua/plugins/`: Plugin configurations. Each file represents a plugin or a related group of plugins.
*   `ftplugin/`: Filetype-specific configurations (e.g., `sass.lua`, `scss.lua`).

## Installation

1.  Clone this repository into your Neovim configuration directory (usually `~/.config/nvim`).
2.  Start Neovim. `lazy.nvim` will automatically install all the plugins.
3.  **Mason** will automatically install the configured LSPs, linters, and formatters.
    *   You can run `:Mason` to see the status of installed tools.

## Key-bindings

The leader key is set to `<Space>`.

### Editor & Navigation

*   `j`/`k`: Move wrapped lines naturally.
*   `<leader>x`: Save all and quit (`:wa | qa`).
*   `<leader>q`: Quit current window (`:quit`).
*   `<leader>t`: Open terminal in current buffer.
*   `<leader>T`: Open terminal in new tab.
*   `<Esc>` (in terminal): Exit terminal mode.

### Window Management

*   `<C-h/j/k/l>`: Navigate between splits (works in terminal too).
*   `<leader>h`: Move split left.
*   `<leader>l`: Move split right.
*   `<leader>k`: Move split up.
*   `<leader>j`: Move split down.

### File Explorer (Neo-tree)

*   `<leader>e`: Toggle file explorer.
*   `o` / `<CR>`: Open file or folder.
*   `t`: Open in new tab.
*   `<C-v>`: Open in vertical split.
*   `<C-s>`: Open in horizontal split.
*   `a`: Add file/directory.
*   `d`: Delete.
*   `r`: Rename.
*   `c`: Copy.
*   `x`: Cut.
*   `p`: Paste.

### Telescope (Fuzzy Finder)

*   `<leader>?`: Find recently opened files.
*   `<leader><space>`: Find existing buffers.
*   `<leader>/`: Fuzzily search in current buffer.
*   `<leader>gf`: Search Git files.
*   `<leader>sf`: Search files (all).
*   `<leader>sh`: Search help tags.
*   `<leader>sw`: Search current word (grep).
*   `<leader>sg`: Live grep search.
*   `<leader>sd`: Search diagnostics.

### LSP (Language Server Protocol)

*   `gd`: Go to definition.
*   `gr`: Go to references.
*   `gI`: Go to implementation.
*   `gD`: Go to declaration.
*   `<leader>D`: Type definition.
*   `<leader>rn`: Rename symbol.
*   `<leader>ca`: Code action.
*   `<leader>f`: Format current buffer.
*   `K`: Hover documentation.
*   `<C-k>`: Signature help.
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

### Git (gitsigns)

*   `<leader>gn`: Next hunk.
*   `<leader>gp`: Previous hunk.
*   `<leader>gv`: Preview hunk.
*   `<leader>gb`: Blame line.

### Task Runner (Overseer)

*   `<leader>o`: Toggle Overseer window.
*   `<leader>or`: Run a task.
*   `<leader>oss`: Save session.
*   `<leader>osl`: Load session.

### Autocompletion (nvim-cmp)

*   `<C-n>` / `<Tab>`: Select next item.
*   `<C-p>` / `<S-Tab>`: Select previous item.
*   `<C-b>`: Scroll documentation up.
*   `<C-f>`: Scroll documentation down.
*   `<C-Space>`: Trigger completion manually.
*   `<C-e>`: Abort completion.
*   `<CR>`: Confirm completion.

### Copilot

*   `<C-l>`: Accept suggestion.
*   `<C-h>`: Dismiss suggestion.

### Comments (Comment.nvim)

*   `gc`: Toggle comment (linewise).
*   `gb`: Toggle comment (blockwise).