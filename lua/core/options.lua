-- [[ Setting options ]]
-- See `:help option-list`
vim.opt.backup = false -- Do not create a backup file
-- vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.cmdheight = 1 -- More space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- Options for code completion
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.fileencoding = "utf-8" -- The encoding written to a file
vim.opt.hlsearch = true -- Highlight all matches on previous search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.mouse = "a" -- Allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- Pop up menu height
vim.opt.showmode = false -- Don't show the mode since it's in the status line
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.smartcase = true -- Smart case
vim.opt.smartindent = true -- Make indenting smarter again
vim.opt.splitbelow = true -- Force all horizontal splits to go below current window
vim.opt.splitright = true -- Force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- Creates a swapfile
vim.opt.termguicolors = true -- Set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- Time in milliseconds to wait for a mapped sequence to complete
vim.opt.undofile = true -- Enable persistent undo
vim.opt.updatetime = 300 -- Faster completion
vim.opt.writebackup = false -- If a file is being edited by another program (or was written to file while editing)
vim.opt.autoread = true -- Automatically re-read files changed outside of neovim
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- The number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.cursorline = true -- Highlight the current line
vim.opt.number = true -- Set numbered lines
vim.opt.relativenumber = true -- Set relative numbered lines
vim.opt.numberwidth = 4 -- Set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true -- Display lines as one long line
vim.opt.scrolloff = 8 -- Lines of context
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.guifont = "monospace:h17" -- The font used in graphical neovim applications
vim.opt.shortmess:append("c")
vim.opt.wildoptions:remove("pum")
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
