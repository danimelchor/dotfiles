require('trouble').setup({
  action_keys = {
    open_split = { "S" },  -- open buffer in new split
    open_vsplit = { "s" }, -- open buffer in new vsplit
  }
})

vim.keymap.set("n", "<leader>e", "<cmd>TroubleToggle document_diagnostics<cr>", { noremap = true, silent = true })
