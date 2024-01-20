return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local FormatGroup = vim.api.nvim_create_augroup("FormatGroup", {})
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = FormatGroup,
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
    event = "BufEnter"
  },

  -- Errors an diagnostics
  {
    "folke/trouble.nvim",
    config = function()
      require('trouble').setup({
        action_keys = {
          open_split = { "S" },  -- open buffer in new split
          open_vsplit = { "s" }, -- open buffer in new vsplit
        }
      })

      vim.keymap.set("n", "<leader>e", "<cmd>TroubleToggle document_diagnostics<cr>", { noremap = true, silent = true })
    end,
    event = "BufEnter"
  }
}
