vim.api.nvim_create_user_command('Diff', 'DiffviewOpen', { nargs = 0 })
vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.formatting()', { nargs = 0 })

