vim.g.mapleader = " " -- space as leader key (used by plugin keymaps)

-- Disable remote-plugin providers (unused; silences checkhealth warnings)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt

-- Indentation: 2 spaces, rounded to shiftwidth
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.shiftround = true

-- Scrolling / UI
opt.scrolloff = 3
opt.number = true         -- current line shows actual number
opt.relativenumber = true -- other lines show distance
opt.cursorline = true
opt.signcolumn = "yes"    -- always show sign column (avoids text jumping with gitsigns/LSP)
opt.termguicolors = true  -- true color support
opt.splitright = true
opt.splitbelow = true

-- Search: case-insensitive unless you type a capital
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

-- Persistent undo across sessions
opt.undofile = true

-- Yank/put uses the system clipboard (no "+ prefix needed)
opt.clipboard = "unnamedplus"

-- Faster CursorHold events (used by some plugins)
opt.updatetime = 250

-- Mouse wheel: 1 line per scroll event 
opt.mousescroll = "ver:1,hor:3"

-- Skip the intro/splash message on startup
opt.shortmess:append("I")

-- Enable markdown folding (used by autocmds.lua)
vim.g.markdown_folding = 1
