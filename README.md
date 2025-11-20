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
*   **UI/UX:**
    *   Statusline: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
    *   Bufferline: [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
    *   File Explorer: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
    *   Colorscheme: [Tokyonight](https://github.com/folke/tokyonight.nvim)
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

### General

*   `<leader>e`: Toggle file explorer
*   `<leader>?`: Find recently opened files
*   `<leader><space>`: Find existing buffers
*   `<leader>/`: Fuzzily search in current buffer
*   `<leader>sf`: Search files
*   `<leader>sh`: Search help
*   `<leader>sw`: Search current word
*   `<leader>sg`: Search by Grep
*   `<leader>sd`: Search diagnostics

### LSP

*   `<leader>rn`: Rename
*   `<leader>ca`: Code action
*   `<leader>f`: Format
*   `gd`: Go to definition
*   `gr`: Go to references
*   `gI`: Go to implementation
*   `K`: Hover documentation
*   `<C-k>`: Signature help

### Debugger

*   `<F5>`: Start/Continue
*   `<F1>`: Step into
*   `<F2>`: Step over
*   `<F3>`: Step out
*   `<leader>b`: Toggle breakpoint
*   `<leader>B`: Set conditional breakpoint

### Git (gitsigns)

*   `<leader>gn`: Next hunk
*   `<leader>gp`: Previous hunk
*   `<leader>gv`: Preview hunk
*   `<leader>gb`: Blame line

### Overseer (Task Runner)

*   `<leader>o`: Toggle Overseer
*   `<leader>or`: Run a task
*   `<leader>oss`: Save session
*   `<leader>osl`: Load session

### Comments

*   `gc`: Toggle comment linewise
*   `gb`: Toggle comment blockwise

Enjoy your new Neovim configuration!
