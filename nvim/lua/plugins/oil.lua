local function get_ignored(dir)
  local cmd = string.format('git -C %s ls-files --ignored --exclude-standard --others --directory | grep -v \"/.*\\/\"',
    dir)

  local handle = io.popen(cmd)
  if handle == nil then
    return
  end

  local output = handle:read('*a')
  handle:close()

  local lines = vim.split(output, '\n')
  local ignored_files = {}
  for _, line in ipairs(lines) do
    -- Remove trailing slash
    line = line:gsub('/$', '')
    table.insert(ignored_files, line)
  end
  table.insert(ignored_files, '.git')
  table.insert(ignored_files, '..')
  return ignored_files
end

local Cache = require('utils').Cache
local cache = Cache.new(get_ignored)


return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require('oil')
      oil.setup({
        use_default_keymaps = false,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          is_hidden_file = function(name, _)
            local ignored_files = cache:call(oil.get_current_dir())
            return vim.tbl_contains(ignored_files, name)
          end,
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["I"] = "actions.toggle_hidden",
          ["<CR>"] = "actions.select",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["R"] = "actions.refresh",
          ["<LEADER>n"] = "actions.close",
          ["s"] = function()
            require('oil.actions').select_vsplit.callback()
            require('oil.actions').close.callback()
          end,
          ["S"] = function()
            require('oil.actions').select_split.callback()
            require('oil.actions').close.callback()
          end,
          ["h"] = function()
            -- Function to add oil entry to harpoon
            local Path = require("plenary.path")

            -- Get file under cursor
            local entry = oil.get_cursor_entry()
            local filename = entry and entry.name
            local dir = oil.get_current_dir()

            -- Add to harpoon
            local listItem = {
              context = { row = 1, col = 0 },
              value = Path:new(dir .. filename):make_relative(vim.fn.getcwd()),
            }
            require("harpoon"):list():append(listItem)
          end
        }
      })

      vim.api.nvim_set_keymap('n', '<LEADER>n', '<Cmd>Oil<CR>', { noremap = true, silent = true, desc = 'Open Oil' })
    end,
  }
}
