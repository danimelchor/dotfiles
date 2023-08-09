local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
end

map('<SPACE>', '<Nop>')

-- Neo tree
map('<LEADER>n', '<Cmd>Neotree toggle filesystem left focus reveal<CR>', '[N]eotree')

-- Git
map('<LEADER>gb', '<Cmd>Gitsigns blame_line<CR>', '[G]it [B]lame current line')

-- Tmux
map("<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", "Open tmux session")

-- For practice
map('<UP>', '<Nop>')
map('<LEFT>', '<Nop>')
map('<RIGHT>', '<Nop>')
map('<DOWN>', '<Nop>')

-- Search files with GFiles fallback
map('<LEADER>fb', '<Cmd>Telescope git_branches<CR>', '[F]ind [B]ranches')
map('<LEADER>fh', '<Cmd>Telescope oldfiles only_cwd=true initial_mode=normal<CR>', '[F]ind [H]istory')
map('<LEADER>fe', '<Cmd>Telescope diagnostics initial_mode=normal<CR>', '[F]ind [E]rrors')
map('<LEADER>km', '<Cmd>Telescope keymaps<CR>', '[K]ey[M]aps')
map('<LEADER>fc', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', '[F]ind words in [C]urrent buffer')
map('<LEADER>fn', '<Cmd>:enew<CR>', '[F]ile [N]ew')
local function find_repo_name()
  return vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":p:h:h:t")
end
vim.keymap.set("n", "<leader>fg", function()
  require("telescope").extensions.livegrep.livegrep({
    repo = "stripe-internal/" .. find_repo_name(),
  })
end, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fs", function()
  require("telescope").load_extension("aerial")
  vim.cmd("Telescope aerial")
end, { desc = "[F]ind Document [S]ymbol" })

-- Tmux
map("<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", "Open tmux session")

-- Comment
vim.keymap.set('n', 'gcc', function()
    return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_linewise_current)'
        or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true, desc = 'Toggle comment' })
vim.keymap.set('x', 'gc', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment' })
