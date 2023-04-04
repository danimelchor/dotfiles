vim.keymap.set("n", "<Leader>ae", "<cmd>AerialToggle<CR>", { silent = true, desc = "Open code outline " })
require('aerial').setup({
  layout = {
    max_width = 40,
    min_width = 20,
  },
  close_automatic_events = { "switch_buffer" },
  manage_folds = false,
  link_folds_to_tree = false,
  link_tree_to_folds = true,
  treesitter = {
    update_delay = 100,
  },
  keymaps = {
        ["<CR>"] = "actions.scroll",
        ["q"] = "actions.close",
        ["o"] = "actions.tree_toggle",
        ["O"] = "actions.tree_toggle_recursive",
  },
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
    "Field",
    "Key",
    "Namespace",
    "Property",
  },
})
