vim.keymap.set("n", '<SPACE>', '<Nop>')

-- Tmux
vim.keymap.set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux session" })

-- For practice
vim.keymap.set("n", '<UP>', '<Nop>')
vim.keymap.set("n", '<LEFT>', '<Nop>')
vim.keymap.set("n", '<RIGHT>', '<Nop>')
vim.keymap.set("n", '<DOWN>', '<Nop>')
vim.keymap.set("n", "Q", "<nop>")

-- Up and down + center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Next/Previous occurance + center + unfold
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])                                               -- Paste without yanking
vim.keymap.set("x", "<leader>d", [["_d]])                                                -- Delete without yanking
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Replace the word under cursor

-- LSP
local DmelchorGroup = vim.api.nvim_create_augroup('DmelchorGroup', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = DmelchorGroup,
  callback = function(ev)
    local opts = { buffer = ev.buf, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<LEADER>D', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', '<LEADER>r', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<LEADER>a', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<LEADER>f', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', 'ge', function() vim.diagnostic.open_float() end, opts)
  end
})
