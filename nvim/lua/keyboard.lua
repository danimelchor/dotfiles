local map = vim.keymap.set
local opts = { noremap=true, silent=true }

map('n','<SPACE>','<Nop>', opts)

-- Search files with GFiles fallback
-- map('n', '<LEADER>ff', '<Cmd>lua require"plugins.telescope".project_files()<CR>', opts)
map('n', '<LEADER>ff', function()
    local isInGitRepo = vim.api.nvim_command_output("echo (len(system('git rev-parse --is-inside-work-tree')) == 5)")

    if isInGitRepo == "1"
    then vim.cmd("GFiles")
    else vim.cmd("Files")
    end
end, opts)
map('n', '<LEADER>fw', '<Cmd>:Rg<CR>', opts)
map('n', '<LEADER>fb', '<Cmd>Telescope git_branches<CR>', opts)
map('n', '<LEADER>fh', '<Cmd>Telescope oldfiles<CR>', opts)
map('n', '<LEADER>fe', '<Cmd>Telescope diagnostics<CR>', opts)

-- Syntax
map('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
map('n', 'gi', '<Cmd>Telescope lsp_implementations<CR>', opts)
map('n', 'gr', '<Cmd>Telescope lsp_references<CR>', opts)
map('n', 'gt', '<Cmd>Telescope lsp_type_definitions<CR>', opts)

-- Neo tree
map('n', '<LEADER>n', '<Cmd>Neotree toggle filesystem left focus reveal<CR>', opts)

-- Git
map('n', '<LEADER>gb', '<Cmd>GitBlameToggle<CR>', opts)

-- Terminal
map('n', '<LEADER>t', '<Cmd>ToggleTerm size=15 direction=horizontal<CR>', opts)

-- Utils
map('n','<LEADER>o','o<ESC>k', opts)
map('n','<LEADER>O','O<ESC>j', opts)
map('n','<LEADER>q','<Cmd>tabclose<CR>', opts)
map('n','<LEADER>r','<Cmd>Run<CR>', opts)
map('n','<LEADER>pc','<Cmd>PackerCompile<CR>', opts)
map('n','<LEADER>cp','<Cmd>let @+ = expand("%")<CR>', opts)
map('n', '<LEADER>fn', '<Cmd>enew<CR>', opts)

-- Wrap around keys
map('v','<LEADER>"','di"<ESC>gpa"<ESC>', opts)
map('v','<LEADER>\'','di\'<ESC>gpa\'<ESC>', opts)
map('v','<LEADER>(','di(<ESC>gpa)<ESC>', opts)
map('v','<LEADER>[','di[<ESC>gpa]<ESC>', opts)
map('v','<LEADER>{','di{<ESC>gpa}<ESC>', opts)

-- Switch between splits
map('n', '<S-Up>', '<C-W>k', opts)
map('n', '<S-Right>', '<C-W>l', opts)
map('n', '<S-Left>', '<C-W>h', opts)
map('n', '<S-Down>', '<C-W>j', opts)

-- Switch between tabs
map('n', '<TAB>', '<Cmd>:BufferLineCycleNext<CR>', opts)
map('n', '<S-TAB>', '<Cmd>:BufferLineCyclePrev<CR>', opts)
map('n', 'g<TAB>', '<Cmd>:BufferLinePick<CR>', opts)

-- For practice
map('n', '<UP>', '<Nop>', opts)
map('n', '<LEFT>', '<Nop>', opts)
map('n', '<RIGHT>', '<Nop>', opts)
map('n', '<DOWN>', '<Nop>', opts)
