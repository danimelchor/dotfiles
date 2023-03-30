require('catppuccin').setup()
vim.cmd("colorscheme catppuccin")

vim.opt.termguicolors = true
vim.cmd("silent! syntax enable")
vim.cmd("silent! hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("silent! hi EndOfBuffer guibg=NONE ctermbg=NONE")
