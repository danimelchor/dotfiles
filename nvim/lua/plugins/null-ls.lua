local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  diagnostics_format = "#{m} (#{s})",
  sources = {
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.rubocop,
    formatting.codespell,
    formatting.gofmt,
    diagnostics.eslint.with {
        diagnostics_format = "[#c] #{m} (#{s})",
    },
    diagnostics.codespell,
    diagnostics.flake8,
    diagnostics.jsonlint,
    diagnostics.rubocop,
    diagnostics.yamllint
  },
})
