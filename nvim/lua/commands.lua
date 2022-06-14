vim.api.nvim_create_user_command('Diff', 'DiffviewOpen', { nargs = 0 })
vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.formatting()', { nargs = 0 })
vim.api.nvim_create_user_command('Run', function()
    require('plugins.runner').run()
end, { nargs = 0 })

vim.api.nvim_command([[
augroup AutoWrapLines
autocmd BufEnter * :set wrap
augroup END
]])
