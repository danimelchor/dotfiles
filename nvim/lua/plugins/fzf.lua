local fzf = require('fzf-lua')
fzf.setup({
  'telescope',
})

if vim.fn.executable("fzf") ~= 1 then
  vim.notify("fzf not found. brew install fzf", vim.log.levels.WARN)
end

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

map('<C-p>', function()
  local opts = {
    cwd = vim.fn.getcwd(),
  }
  local ok = pcall(fzf.git_files, opts)
  if not ok then fzf.files(opts) end
end, "Find project files")

map('<C-S-p>', function()
  local ok = pcall(fzf.git_files)
  if not ok then fzf.files() end
end, "Find files")

map('<LEADER>fw', fzf.grep, '[F]ind [W]ords')
map('<LEADER>fb', fzf.git_branches, '[F]ind [B]ranches')
map('<LEADER>fs', fzf.lsp_document_symbols, '[F]ind [S]ymbols')
map('<LEADER>fd', fzf.diagnostics_document, '[F]ind [D]iagnostics')
map('<LEADER>km', fzf.keymaps, '[K]ey[M]aps')
map('<LEADER>fh', function() fzf.oldfiles({ cwd_only = true }) end, '[F]ind [H]istory')
