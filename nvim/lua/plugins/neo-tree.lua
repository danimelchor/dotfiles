local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
  return
end

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neo_tree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      padding = 0,
      with_expanders = false,
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
    },
    git_status = {
      symbols = {
        added = "",
        deleted = "",
        modified = "",
        renamed = "➜",
        untracked = "★",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
      },
    },
  },
  window = {
    width = "50",
    mappings = {
      ["o"] = "open",
      ["n"] = "add",
      ["d"] = "delete",
      ["r"] = "rename",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        "node_modules",
        "__pycache__",
        ".git",
        "venv",
      },
    },
    follow_current_file = true,
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = "open_current",
  },
  git_status = {
    window = {
      position = "float",
    },
  },
  buffers = {
    follow_current_file = true,
    group_empty_dirs = false
  },
  event_handlers = {
    {
      event = "vim_buffer_enter",
      handler = function(_)
        if vim.bo.filetype == "neo-tree" then
          vim.wo.signcolumn = "auto"
        end
      end,
    },
  },
})
