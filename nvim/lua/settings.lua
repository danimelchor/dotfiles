local opt = vim.opt
local g = vim.g
local o = vim.o

-- General settings
opt.linespace = 0
opt.showmatch = true
opt.splitright = true
opt.ttimeoutlen = 0
opt.ruler = false
opt.exrc = true
opt.relativenumber = true
opt.autoindent = true
opt.smarttab = true
opt.number = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand('~') .. '/.config/nvim/undo'
opt.undofile = true
opt.incsearch = true
opt.scrolloff = 10
opt.signcolumn = 'yes'
opt.title = true
opt.autoread = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.fileencoding = 'utf-8'
opt.wrap = false
opt.mouse = "a"
opt.clipboard = "unnamed"
opt.cmdheight = 0

o.showmode = false
o.breakindent = true
o.showbreak = "↳ "

g.mapleader = " "

-- Toggle relative line numbering
vim.cmd("command! ToggleRelLines set relativenumber!")
