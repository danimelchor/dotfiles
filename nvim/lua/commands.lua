vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.format({async = true})', { nargs = 0 })

vim.api.nvim_create_user_command('VSCode', '!code -g %:p', { nargs = 0 })
vim.api.nvim_create_user_command('IntelliJ', '!idea %:p --line', { nargs = 0 })

vim.api.nvim_create_user_command('IsStripe', function() print(require('utils').is_stripe()) end, { nargs = 0 })

vim.api.nvim_command([[
augroup AutoWrapLines
autocmd BufEnter * :set wrap
augroup END
]])

local YankHighlight = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "Search",
    })
  end,
  group = YankHighlight,
  pattern = "*",
})

local VertHelp = vim.api.nvim_create_augroup("VertHelp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if vim.bo.filetype == "help" then
      vim.api.nvim_command("wincmd L")
    end
  end,
  group = VertHelp,
  pattern = "help",
})

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = "Disable autoformat-on-save", bang = true, })
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save", })
