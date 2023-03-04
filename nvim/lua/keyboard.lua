local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
end

map('<SPACE>', '<Nop>')

-- Search files with GFiles fallback
-- map('n', '<LEADER>ff', '<Cmd>lua require"plugins.telescope".project_files()<CR>')
map('<LEADER>ff', function()
    local isInGitRepo = vim.api.nvim_command_output("echo (len(system('git rev-parse --is-inside-work-tree')) == 5)")

    if isInGitRepo == "1"
    then
        vim.cmd("GFiles")
    else
        vim.cmd("Files")
    end
end, "[F]ind [F]iles")
map('<LEADER>fw', '<Cmd>:Rg<CR>', '[F]ind [W]ords')
map('<LEADER>fb', '<Cmd>Telescope git_branches<CR>', '[F]ind [B]ranches')
map('<LEADER>fh', '<Cmd>Telescope oldfiles only_cwd=true initial_mode=normal<CR>', '[F]ind [H]istory')
map('<LEADER>fe', '<Cmd>Telescope diagnostics initial_mode=normal<CR>', '[F]ind [E]rrors')
map('<LEADER>km', '<Cmd>Telescope keymaps<CR>', '[K]ey[M]aps')
map('<LEADER>fc', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', '[F]ind words in [C]urrent buffer')
map('<LEADER>fn', '<Cmd>:enew<CR>', '[F]ile [N]ew')

-- Syntax
map('gd', '<Cmd>Telescope lsp_definitions<CR>', '[G]o to [D]efinition')
map('gi', '<Cmd>Telescope lsp_implementations initial_mode=normal<CR>', '[G]o to [I]mplementation')
map('gr', '<Cmd>Telescope lsp_references initial_mode=normal<CR>', '[G]o to [R]eferences')
map('gt', '<Cmd>Telescope lsp_type_definitions<CR>', '[G]o to [T]ype definitions')
map('gb', '<C-o>', '[G]o [B]ack')
map('k', vim.lsp.bug.hover, 'Hover')

-- Neo tree
map('<LEADER>n', '<Cmd>Neotree toggle filesystem left focus reveal<CR>', '[N]eotree')

-- Git
map('<LEADER>gb', '<Cmd>Gitsigns blame_line<CR>', '[G]it [B]lame current line')

-- Save and format
map('<LEADER>w', function()
    vim.lsp.buf.formatting_sync()
    vim.cmd('w')
end, 'Save and format')

-- Switch between tabs
map('<TAB>', '<Cmd>:BufferLineCycleNext<CR>', 'Switch to next tab')
map('<S-TAB>', '<Cmd>:BufferLineCyclePrev<CR>', 'Switch to previous tab')
map('g<TAB>', '<Cmd>:BufferLinePick<CR>', 'Go to tab')

-- Tmux
map("<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", "Open tmux session")

-- For practice
map('<UP>', '<Nop>')
map('<LEFT>', '<Nop>')
map('<RIGHT>', '<Nop>')
map('<DOWN>', '<Nop>')

-- Comment
vim.keymap.set('n', 'gcc', function()
  return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_linewise_current)'
      or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true, desc = 'Toggle comment' })
vim.keymap.set('x', 'gc', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment' })
