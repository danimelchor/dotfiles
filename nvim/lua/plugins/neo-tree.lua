local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
  return
end

neo_tree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_diagnostics = false,
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
      ["a"] = "add",
      ["d"] = "delete",
      ["r"] = "rename",
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
      },
    },
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
  },
  git_status = {
    window = {
      position = "float",
    },
  },
  buffers = {
    follow_current_file = true,
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
    {
      event = "file_opened",
      handler = function(file_path)
        require("neo-tree").focus()
      end
    },
    -- {
    --   event = "vim_win_enter",
    --   handler = function(file_path)
    --     require("neo-tree").close_all()
    --   end
    -- }
  },
})

vim.cmd([[
augroup CloseNeotreeOnTab
  autocmd!
  autocmd Tabenter * lua require('neo-tree').close_all()
augroup END
]])
