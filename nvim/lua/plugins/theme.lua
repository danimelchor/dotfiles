require('catppuccin').setup()
vim.cmd("colorscheme catppuccin")

vim.cmd([[ hi DashboardHeader ctermbg=0 guifg=#fab387 ]])
vim.cmd([[ hi DashboardCenter ctermbg=0 guifg=#89b4fa ]])
vim.cmd([[ hi DashboardShortcut ctermbg=0 guifg=#89dceb ]])

vim.opt.termguicolors = true
vim.cmd("silent! syntax enable")
vim.cmd("silent! hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("silent! hi EndOfBuffer guibg=NONE ctermbg=NONE")
