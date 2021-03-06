local opt = vim.opt
local g = vim.g

-- General settings
opt.linespace     = 0 -- No extra spaces between rows
opt.showmatch     = true -- Show matching brackets/parentthesis
opt.splitright    = true -- Vertical splits to the right
opt.ttimeoutlen   = 0 -- Timeout for completing commands
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
opt.fileencoding = 'utf-8'
opt.wrap = true
opt.mouse = "a"
opt.clipboard = "unnamed"

g.mapleader = " "
-- Theme settings
opt.termguicolors = true
g.sonokai_style = 'andromeda'
g.sonokai_better_performance = 1
vim.cmd("silent! colorscheme sonokai")
vim.cmd("silent! syntax enable")
vim.cmd("silent! hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("silent! hi EndOfBuffer guibg=NONE ctermbg=NONE")
