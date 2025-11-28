# Neovim Configuration for Full-Stack Web Development

This is a Neovim configuration tailored for full-stack web development, with a focus on SolidJS and SolidStart. It's built using Lua and managed by the `lazy.nvim` plugin manager.

## Features

*   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **Language Support:** Lua, JavaScript, TypeScript, Python, HTML, CSS, SQL.
*   **Core Plugins:**
    *   LSP: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    *   Treesitter: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    *   Fuzzy Finder: [Telescope](https://github.com/nvim-telescope/telescope.nvim)
    *   Git Integration: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
    *   Debugger: [nvim-dap](https://github.com/mfussenegger/nvim-dap)
    *   Commenting: [Comment.nvim](https://github.com/numToStr/Comment.nvim)
    *   Development Utilities: [neodev.nvim](https://github.com/folke/neodev.nvim)
*   **UI/UX:**
    *   Statusline: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
    *   Bufferline: [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
    *   File Explorer: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
    *   Colorscheme: [Catppuccin](https://github.com/catppuccin/nvim)
*   **Performance:** Lazy loading for fast startup times.
*   **Linting/Formatting:**
    *   Formatting: [conform.nvim](https://github.com/stevearc/conform.nvim)
    *   Linting: [nvim-lint](https://github.com/mfussenegger/nvim-lint)
    *   Linters: ESLint, Ruff
    *   Formatters: Prettier, Black
*   **Build Tools:** [overseer.nvim](https://github.com/stevearc/overseer.nvim) for task running.
*   **Autocompletion:**
    *   [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    *   [Copilot](https://github.com/zbirenbaum/copilot.lua)

## Structure

The configuration is organized into the following directories:

*   `init.lua`: The entry point of the configuration. It sets up `lazy.nvim` and loads the rest of the configuration.
*   `lua/core/`: Core Neovim settings, options, and keymaps.
*   `lua/plugins/`: Plugin configurations, with each file representing a plugin or a group of related plugins.
*   `lua/utils/`: Utility functions (currently empty).

## Installation

1.  Clone this repository into your Neovim configuration directory (usually `~/.config/nvim`).
2.  Start Neovim. `lazy.nvim` will automatically install all the plugins.
3.  You may need to run `:Mason` to install the LSPs, linters, and formatters.

## Key-bindings

The leader key is set to `<Space>`.

### Editor

*   `j`/`k`: Move wrapped lines
*   `<leader>x`: Save all and quit
*   `<leader>q`: Quit current window
*   `<leader>t`: Open terminal in current buffer
*   `<leader>T`: Open terminal in new tab
*   `<Esc>`: Exit terminal mode (in terminal)

### Window Management

*   `<C-h>`: Go to left split
*   `<C-l>`: Go to right split
*   `<C-k>`: Go to upper split
*   `<C-j>`: Go to lower split
*   `<leader>h`: Move split left
*   `<leader>l`: Move split right
*   `<leader>k`: Move split up
*   `<leader>j`: Move split down

### Bufferline

*   `J`: Previous tab
*   `K`: Next tab
*   `Q`: Close current tab

### Telescope

*   `<leader>?`: Find recently opened files
*   `<leader><space>`: Find existing buffers
*   `<leader>/`: Fuzzily search in current buffer
*   `<leader>gf`: Find git files
*   `<leader>sf`: Find files
*   `<leader>sh`: Search help
*   `<leader>sw`: Search current word
*   `<leader>sg`: Search by Grep
*   `<leader>sd`: Search diagnostics

### LSP (Language Server Protocol)

*   `<leader>rn`: Rename
*   `<leader>ca`: Code action
*   `<leader>f`: Format
*   `gd`: Go to definition
*   `gr`: Go to references
*   `gI`: Go to implementation
*   `<leader>D`: Type Definition
*   `<leader>ds`: Document Symbols
*   `<leader>ws`: Workspace Symbols
*   `K`: Hover documentation
*   `<C-k>`: Signature help
*   `gD`: Go to Declaration
*   `<leader>wa`: Workspace Add Folder
*   `<leader>wr`: Workspace Remove Folder
*   `<leader>wl`: Workspace List Folders

### Debugger (nvim-dap)

*   `<F5>`: Start/Continue
*   `<F1>`: Step into
*   `<F2>`: Step over
*   `<F3>`: Step out
*   `<F7>`: See last session result
*   `<leader>b`: Toggle breakpoint
*   `<leader>B`: Set conditional breakpoint

### Git (gitsigns)

*   `<leader>gn`: Next hunk
*   `<leader>gp`: Previous hunk
*   `<leader>gv`: Preview hunk
*   `<leader>gb`: Blame line

### Task Runner (Overseer)

*   `<leader>o`: Toggle Overseer
*   `<leader>or`: Run a task
*   `<leader>oss`: Save session
*   `<leader>osl`: Load session

### File Explorer (neo-tree)

*   `<leader>e`: Toggle file explorer
*   `t`: Open in new tab
*   Line numbering is enabled by default.
*   `o` or `<CR>`: Open file or folder
*   `<C-v>`: Open in vertical split
*   `<C-s>`: Open in horizontal split
*   `<C-t>`: Open in new tab
*   `a`: Add a file or directory
*   `d`: Delete a file or directory
*   `r`: Rename a file or directory
*   `c`: Copy a file or directory
*   `x`: Cut a file or directory
*   `p`: Paste
*   `q`: Close the tree
*   `R`: Refresh the tree
*   `H`: Toggle hidden files
*   `g?`: Show help

### Autocompletion (nvim-cmp)

*   `<C-n>`/`<Tab>`: Select next item
*   `<C-p>`/`<S-Tab>`: Select previous item
*   `<C-b>`: Scroll documentation up
*   `<C-f>`: Scroll documentation down
*   `<C-Space>`: Trigger completion
*   `<C-e>`: Abort completion
*   `<CR>`: Confirm completion

### Copilot

*   `<C-l>`: Accept suggestion
*   `<C-h>`: Dismiss suggestion

### Comments (Comment.nvim)

*   `gc`: Toggle comment linewise
*   `gb`: Toggle comment blockwise

Enjoy your new Neovim configuration!
