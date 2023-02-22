require('nightfox').setup({
  options = {
    dim_inactive = true,
  }
})

vim.cmd("colorscheme nightfox")
vim.cmd([[ hi DashboardHeader ctermbg=0 guifg=#56b6c2 ]])
vim.cmd([[ hi DashboardCenter ctermbg=0 guifg=#61afef ]])
vim.cmd([[ hi DashboardShortcut ctermbg=0 guifg=#e5c07b ]])
