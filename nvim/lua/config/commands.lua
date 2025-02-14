vim.api.nvim_create_user_command('VSCode', '!code -g %:p', { nargs = 0 })
vim.api.nvim_create_user_command('IntelliJ', '!idea %:p --line', { nargs = 0 })

vim.api.nvim_create_user_command('IsStripe', function() print(require('config.utils').is_stripe()) end, { nargs = 0 })
vim.api.nvim_create_user_command(
  'Update',
  function()
    vim.api.nvim_command('TSUpdate')
    vim.api.nvim_command('Lazy update')
    vim.api.nvim_command('MasonUpdate')
  end,
  { nargs = 0 }
)

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
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "help" then
      vim.api.nvim_command("wincmd L")
    end
  end,
  group = VertHelp,
  pattern = { "*.txt" },
})

-- Make `.sky` files Python filetype
local SkyFileType = vim.api.nvim_create_augroup("SkyFileType", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.fn.expand("%:e") == "sky" then
      vim.bo.filetype = "python"
      vim.cmd("FormatDisable")
      vim.cmd("LintDisable")
      vim.notify("Sky files treated as Python", vim.log.levels.INFO)
    end
  end,
  group = SkyFileType,
  pattern = { "*.sky" },
})
