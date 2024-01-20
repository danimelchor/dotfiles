local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

map('<SPACE>', '<Nop>')

-- Git
map('<LEADER>gb', '<Cmd>Gitsigns blame_line<CR>', '[G]it [B]lame current line')

-- Tmux
map("<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", "Open tmux session")

-- For practice
map('<UP>', '<Nop>')
map('<LEFT>', '<Nop>')
map('<RIGHT>', '<Nop>')
map('<DOWN>', '<Nop>')

-- Tmux
map("<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", "Open tmux session")

-- Comment
vim.keymap.set('n', 'gcc', function()
  return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_linewise_current)'
      or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true, desc = 'Toggle comment' })
vim.keymap.set('x', 'gc', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment' })
