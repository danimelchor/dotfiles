local km = vim.keymap

km.set('n','<SPACE>','<Nop>')

-- Search files with GFiles fallback
km.set('n', '<LEADER>ff', function()
    local isInGitRepo = vim.api.nvim_command_output("echo (len(system('git rev-parse --is-inside-work-tree')) == 5)")

    if isInGitRepo == "1"
    then vim.cmd(":GFiles")
    else vim.cmd(":Files")
    end
end)
km.set('n', '<LEADER>fw', '<Cmd>:Rg<CR>')

-- Syntax
local opts = { noremap=true, silent=true }
km.set('n', 'gd', '<Cmd>lua require("lspsaga.provider").preview_definition()<CR>', opts)
km.set('n', 'gi', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
km.set('n', 'gs', '<Cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
km.set('n', 'ge', '<Cmd>lua require("lspsaga.diagnostic").show_cursor_diagnostics()<CR>', opts)

-- Neo tree
km.set('n', '<LEADER>n', function()
    local windowsOpened = vim.api.nvim_command_output("echo map(range(1, winnr('$')), 'getwinvar(v:val, \"&ft\")')")
    local isNerdTreeFocused = vim.api.nvim_command_output("echo &ft") == "neo-tree"
    local isNertTreeOpened = string.find(windowsOpened, "neo%-tree")

    if isNertTreeOpened and isNerdTreeFocused
    then vim.cmd(':Neotree close')
    else vim.cmd(':Neotree show focus filesystem left')
    end
end)

-- Git
km.set('n', '<LEADER>gb', '<Cmd>:GitBlameToggle<CR>')

-- Terminal
km.set('n', '<LEADER>t', '<Cmd>:ToggleTerm size=15 direction=horizontal<CR>')

-- Utils
km.set('n','<LEADER>o','o<ESC>k')
km.set('n','<LEADER>O','O<ESC>j')
km.set('n','<LEADER>q','<Cmd>:tabclose<CR>')
km.set('n','<LEADER>r','<Cmd>:Run<CR>')

-- Wrap around keys
km.set('v','<LEADER>"','di"<ESC>gpa"<ESC>')
km.set('v','<LEADER>\'','di\'<ESC>gpa\'<ESC>')
km.set('v','<LEADER>(','di(<ESC>gpa)<ESC>')
km.set('v','<LEADER>[','di[<ESC>gpa]<ESC>')
km.set('v','<LEADER>{','di{<ESC>gpa}<ESC>')

-- Switch between splits 
km.set('n', '<S-Up>', '<C-W>k')
km.set('n', '<S-Right>', '<C-W>l')
km.set('n', '<S-Left>', '<C-W>h')
km.set('n', '<S-Down>', '<C-W>j')

-- Switch between tabs
km.set('n', '<TAB>', '<Cmd>:BufferLineCycleNext<CR>')
km.set('n', '<S-TAB>', '<Cmd>:BufferLineCyclePrev<CR>')
km.set('n', 'g<TAB>', '<Cmd>:BufferLinePick<CR>')

-- For practice
km.set('n', '<UP>', '<Nop>')
km.set('n', '<LEFT>', '<Nop>')
km.set('n', '<RIGHT>', '<Nop>')
km.set('n', '<DOWN>', '<Nop>')
