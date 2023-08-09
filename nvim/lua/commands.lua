vim.api.nvim_create_user_command('Diff', 'DiffviewOpen', { nargs = 0 })
vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.format({async = true})', { nargs = 0 })

vim.api.nvim_create_user_command('VSCode', '!code -g %:p', { nargs = 0 })
vim.api.nvim_create_user_command('IntelliJ', '!idea %:p --line', { nargs = 0 })

vim.api.nvim_command([[
augroup AutoWrapLines
autocmd BufEnter * :set wrap
augroup END
]])
