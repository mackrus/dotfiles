-- lua/config/options.lua
local opt = vim.opt

-- Line numbers and cursor
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.showcmd = true -- Show partial commands in status line

-- Indentation and formatting
opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.autoindent = true -- Copy indent from previous line
opt.smartindent = true -- Smart indent for C-like languages
opt.formatoptions = "jcroql" -- Auto-format comments, remove comment leader when joining lines

-- File handling
opt.encoding = "utf-8" -- Use UTF-8 encoding
opt.fileencoding = "utf-8" -- File encoding
opt.swapfile = false -- Disable swap files
opt.undofile = true -- Persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Undo file directory

-- Search and navigation
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive if uppercase in search
opt.incsearch = true -- Incremental search
opt.hlsearch = true -- Highlight search matches

-- UI and behavior
opt.termguicolors = true -- True color support for ghostty
opt.mouse = "a" -- Enable mouse in all modes
opt.clipboard = "unnamedplus" -- Use system clipboard (+ register) for macOS
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right
opt.signcolumn = "yes" -- Always show sign column for diagnostics
opt.wrap = false -- Disable line wrapping
vim.o.guifont = "FiraCode Nerd Font:h12" -- for nice ligatures
-- Set transparent background
vim.o.background = "dark" -- or "light", affects colorscheme defaults
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" }) -- Transparent main background
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" }) -- Transparent floating windows
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" }) -- Transparent sign column (for LSP diagnostics)
vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", ctermbg = "NONE" }) -- Transparent line numbers
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE", ctermbg = "NONE" }) -- Transparent cursor line number

-- Performance
opt.updatetime = 250 -- Faster updates (e.g., for CursorHold)
opt.timeoutlen = 400 -- Shorter timeout for key sequences (e.g., <leader> mappings)

-- Splits
-- opt.splitbelow = true -- New splits below
-- opt.splitright = true -- New splits to the right

-- Python-specific
vim.g.python3_host_prog = vim.env.HOME .. "/.venvs/nvim/bin/python"
opt.path:append("**") -- Enhance :find for Python projects
opt.wildmenu = true -- Command-line completion
opt.wildignore:append({ "*.pyc", "__pycache__" }) -- Ignore Python cache files
vim.opt_local.makeprg = "ruff check % --fix"
vim.opt_local.errorformat = "%f:%l:%c:%m"
-- Typst-specific
vim.g.typst_conceal = 1 -- Enable conceal for Typst (if plugin supports it)

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})