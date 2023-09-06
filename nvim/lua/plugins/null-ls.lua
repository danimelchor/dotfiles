local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local null_utils = require("null-ls.utils")
local is_stripe = require("utils").is_stripe()

local function has_exe(name)
  return function()
    return vim.fn.executable(name) == 1
  end
end

local sources = {
  null_ls.builtins.formatting.prettier,

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

  -- Python
  null_ls.builtins.diagnostics.ruff,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.mypy,
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.isort,
}

if is_stripe then
  local nullls_stripe = require("lspconfig_stripe.null_ls")
  local stripe_sources = {
    -- JavaScript, typescript
    nullls_stripe.diagnostics.eslint_d,
    nullls_stripe.formatting.eslint_d,

    -- Horizon stack
    nullls_stripe.formatting.format_java,
    nullls_stripe.formatting.format_build,
    nullls_stripe.formatting.format_scala,
    nullls_stripe.formatting.format_sql,
  }
  vim.list_extend(sources, stripe_sources)
else
  local alternative_sources = {
    -- JavaScript, typescript
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
  }
  vim.list_extend(sources, alternative_sources)
end

null_ls.setup({
  sources = sources
})
