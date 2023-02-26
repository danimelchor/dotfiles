require('catppuccin').setup()
vim.cmd("colorscheme catppuccin")

vim.cmd([[ hi DashboardHeader ctermbg=0 guifg=#56b6c2 ]])
vim.cmd([[ hi DashboardCenter ctermbg=0 guifg=#61afef ]])
vim.cmd([[ hi DashboardShortcut ctermbg=0 guifg=#e5c07b ]])

vim.opt.termguicolors = true
vim.cmd("silent! syntax enable")
vim.cmd("silent! hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("silent! hi EndOfBuffer guibg=NONE ctermbg=NONE")
