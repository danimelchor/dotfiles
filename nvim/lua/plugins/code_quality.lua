vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  float = {
    source = "always",
    border = "rounded",
    severity_sort = true,
  },
  severity_sort = true,
})


local is_stripe = require('utils').is_stripe()

return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "flake8", "mypy", "ruff" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
        json = { "jsonlint" },
        proto = { "buf_lint" },
      }

      -- Add "codespell" to all filetypes
      for _, linters in pairs(linters_by_ft) do
        table.insert(linters, "codespell")
      end

      local lint = require("lint")
      lint.linters_by_ft = linters_by_ft

      local timer = assert(vim.loop.new_timer())
      local DEBOUNCE_MS = 500
      local LintGroup = vim.api.nvim_create_augroup("LintGroup", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
        group = LintGroup,
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          timer:stop()
          timer:start(
            DEBOUNCE_MS,
            0,
            vim.schedule_wrap(function()
              if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_call(buf, function()
                  lint.try_lint(nil, { ignore_errors = true })
                end)
              end
            end)
          )
        end,
      })
      lint.try_lint(nil, { ignore_errors = true })
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
    cmd = "TroubleToggle",
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    config = function()
      local formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        graphql = { "prettierd" },
        go = { "goimports", "gofmt" },
        lua = { "stylua" },
        python = { "isort", "black" },
        sh = { "shfmt" },
        ["_"] = { "trim_whitespace", "trim_newlines" },
        proto = { "buf" },
      }
      local formatters = nil

      if is_stripe then
        local make_zoolander_formatter = function(cmd)
          return {
            command = "./dev/" .. cmd,
            args = { "$FILENAME" },
            cwd = function(self, ctx)
              return vim.fs.find("zoolander", { upward = true, path = ctx.dirname })[1]
            end,
            require_cwd = true,
            stdin = false,
          }
        end

        formatters = {
          format_sql = make_zoolander_formatter("format-sql"),
          format_build = make_zoolander_formatter("format-build"),
          format_java = make_zoolander_formatter("format-java"),
          format_scala = make_zoolander_formatter("format-scala"),
        }

        formatters_by_ft = vim.tbl_extend("force", formatters_by_ft, {
          sql = { "format_sql" },
          bzl = { "format_build" },
          java = { "format_java" },
          scala = { "format_scala" },
        })
      end

      require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        formatters = formatters,
        format_after_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })

      -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
