local km = vim.keymap
local opts = { noremap=true, silent=true }

km.set('n','<SPACE>','<Nop>', opts)

-- Search files with GFiles fallback
-- km.set('n', '<LEADER>ff', '<Cmd>lua require"plugins.telescope".project_files()<CR>', opts)
km.set('n', '<LEADER>ff', function()
    local isInGitRepo = vim.api.nvim_command_output("echo (len(system('git rev-parse --is-inside-work-tree')) == 5)")

    if isInGitRepo == "1"
    then vim.cmd(":GFiles")
    else vim.cmd(":Files")
    end
end, opts)
km.set('n', '<LEADER>fw', '<Cmd>:Rg<CR>', opts)
km.set('n', '<LEADER>fb', '<Cmd>Telescope git_branches<CR>', opts)
km.set('n', '<LEADER>fh', '<Cmd>Telescope oldfiles<CR>', opts)
km.set('n', '<LEADER>fe', '<Cmd>Telescope diagnostics<CR>', opts)

-- Syntax
km.set('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
km.set('n', 'gi', '<Cmd>Telescope lsp_implementations<CR>', opts)
km.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>', opts)
km.set('n', 'gt', '<Cmd>Telescope lsp_type_definitions<CR>', opts)

-- Neo tree
km.set('n', '<LEADER>n', '<Cmd>Neotree toggle filesystem left focus<CR>', opts)
-- km.set('n', '<LEADER>n', function()
--     local windowsOpened = vim.api.nvim_command_output("echo map(range(1, winnr('$', opts)), 'getwinvar(v:val, \"&ft\")')")
--     local isNerdTreeFocused = vim.api.nvim_command_output("echo &ft") == "neo-tree"
--     local isNertTreeOpened = string.find(windowsOpened, "neo%-tree")

--     if isNertTreeOpened and isNerdTreeFocused
--     then vim.cmd(':Neotree close', opts)
--     else vim.cmd(':Neotree show focus filesystem left', opts)
--     end
-- end)

-- Git
km.set('n', '<LEADER>gb', '<Cmd>:GitBlameToggle<CR>', opts)

-- Terminal
km.set('n', '<LEADER>t', '<Cmd>:ToggleTerm size=15 direction=horizontal<CR>', opts)

-- Utils
km.set('n','<LEADER>o','o<ESC>k', opts)
km.set('n','<LEADER>O','O<ESC>j', opts)
km.set('n','<LEADER>q','<Cmd>:tabclose<CR>', opts)
km.set('n','<LEADER>r','<Cmd>:Run<CR>', opts)
km.set('n','<LEADER>pc','<Cmd>:PackerCompile<CR>', opts)
km.set('n','<LEADER>cp','<Cmd>:let @+ = expand("%")<CR>', opts)
km.set('n', '<LEADER>fn', '<Cmd>enew<CR>', opts)

-- Wrap around keys
km.set('v','<LEADER>"','di"<ESC>gpa"<ESC>', opts)
km.set('v','<LEADER>\'','di\'<ESC>gpa\'<ESC>', opts)
km.set('v','<LEADER>(','di(<ESC>gpa)<ESC>', opts)
km.set('v','<LEADER>[','di[<ESC>gpa]<ESC>', opts)
km.set('v','<LEADER>{','di{<ESC>gpa}<ESC>', opts)

-- Switch between splits
km.set('n', '<S-Up>', '<C-W>k', opts)
km.set('n', '<S-Right>', '<C-W>l', opts)
km.set('n', '<S-Left>', '<C-W>h', opts)
km.set('n', '<S-Down>', '<C-W>j', opts)

-- Switch between tabs
km.set('n', '<TAB>', '<Cmd>:BufferLineCycleNext<CR>', opts)
km.set('n', '<S-TAB>', '<Cmd>:BufferLineCyclePrev<CR>', opts)
km.set('n', 'g<TAB>', '<Cmd>:BufferLinePick<CR>', opts)

-- For practice
km.set('n', '<UP>', '<Nop>', opts)
km.set('n', '<LEFT>', '<Nop>', opts)
km.set('n', '<RIGHT>', '<Nop>', opts)
km.set('n', '<DOWN>', '<Nop>', opts)
