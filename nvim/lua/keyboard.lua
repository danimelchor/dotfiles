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
km.set('n', '<LEADER>n', '<CMD>:Neotree toggle filesystem left<CR>')

-- Git
km.set('n', '<LEADER>gb', '<Cmd>:VGit toggle_live_blame<CR>')

-- Terminal
km.set('n', '<LEADER>t', '<Cmd>:ToggleTerm size=15 direction=horizontal<CR>')

-- Utils
km.set('n','<LEADER>o','o<ESC>k')
km.set('n','<LEADER>O','O<ESC>j')
km.set('n','<LEADER>q','<Cmd>:tabclose<CR>')

-- Wrap around keys
km.set('v','<LEADER>"','di"<ESC>gpa"<ESC>')
km.set('v','<LEADER>\'','di\'<ESC>gpa\'<ESC>')
km.set('v','<LEADER>(','di(<ESC>gpa)<ESC>')
km.set('v','<LEADER>[','di[<ESC>gpa]<ESC>')
km.set('v','<LEADER>{','di{<ESC>gpa}<ESC>')

-- Switch between tab
km.set('n', '<S-Up>', '<C-W>k')
km.set('n', '<S-Right>', '<C-W>l')
km.set('n', '<S-Left>', '<C-W>h')
km.set('n', '<S-Down>', '<C-W>j')

-- For practice
km.set('n', '<UP>', '<Nop>')
km.set('n', '<LEFT>', '<Nop>')
km.set('n', '<RIGHT>', '<Nop>')
km.set('n', '<DOWN>', '<Nop>')
