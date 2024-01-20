return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('oil').setup({
        use_default_keymaps = false,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        keymaps = {
          ["g?"] = "actions.show_help",
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
        }
      })

      vim.api.nvim_set_keymap('n', '<LEADER>n', '<Cmd>Oil<CR>', { noremap = true, silent = true, desc = 'Open Oil' })
    end,
  }
}
