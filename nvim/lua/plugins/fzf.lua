local fzf = require('fzf-lua')
fzf.setup({'telescope'})

if vim.fn.executable("fzf") ~= 1 then
  vim.notify("fzf not found. brew install fzf", vim.log.levels.WARN)
end

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

map('<LEADER>ff', function()
  local isInGitRepo = vim.api.nvim_command_output("echo (len(system('git rev-parse --is-inside-work-tree')) == 5)")
  if isInGitRepo == "1"
  then
    fzf.git_files()
  else
    fzf.files()
  end
end, "[F]ind [F]iles")
map('<LEADER>fw', fzf.grep, '[F]ind [W]ords')
