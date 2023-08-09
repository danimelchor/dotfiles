local null_ls = require("null-ls")
local nullls_stripe = require("lspconfig_stripe.null_ls")
local helpers = require("null-ls.helpers")
local null_utils = require("null-ls.utils")
local function has_exe(name)
  return function()
    return vim.fn.executable(name) == 1
  end
end
null_ls.setup({
  sources = {
    -- JavaScript, typescript
    nullls_stripe.diagnostics.eslint_d,
    nullls_stripe.formatting.eslint_d,
    null_ls.builtins.formatting.prettier,

    -- Horizon stack
    nullls_stripe.formatting.format_java,
    nullls_stripe.formatting.format_build,
    nullls_stripe.formatting.format_scala,
    nullls_stripe.formatting.format_sql,

    -- Python
    nullls_stripe.formatting.black,
    nullls_stripe.diagnostics.ruff,

    -- go
    null_ls.builtins.formatting.goimports.with({
      condition = has_exe("goimports"),
    }),
    null_ls.builtins.formatting.gofmt.with({
      condition = has_exe("gofmt"),
    }),

    -- lua
    null_ls.builtins.formatting.stylua.with({
      condition = has_exe("stylua"),
      runtime_condition = helpers.cache.by_bufnr(function(params)
        return null_utils.root_pattern("stylua.toml", ".stylua.toml")(params.bufname)
      end),
    }),

    -- markdown
    null_ls.builtins.diagnostics.vale.with({
      condition = has_exe("vale"),
      runtime_condition = helpers.cache.by_bufnr(function(params)
        return null_utils.root_pattern(".vale.ini")(params.bufname)
      end),
    }),
  },
})
