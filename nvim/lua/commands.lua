vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.format({async = true})', { nargs = 0 })

vim.api.nvim_create_user_command('VSCode', '!code -g %:p', { nargs = 0 })
vim.api.nvim_create_user_command('IntelliJ', '!idea %:p --line', { nargs = 0 })

vim.api.nvim_create_user_command('IsStripe', function() print(require('utils').is_stripe()) end, { nargs = 0 })

vim.api.nvim_command([[
augroup AutoWrapLines
autocmd BufEnter * :set wrap
augroup END
]])

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "Search",
    })
  end,
  group = highlight_group,
  pattern = "*",
})
