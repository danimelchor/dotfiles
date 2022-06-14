local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml", "solidity" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    formatting.black.with { extra_args = { "--fast" } },
    -- formatting.stylua,
    formatting.rubocop,
    formatting.codespell,
    formatting.gofmt,
    formatting.scalafmt,
    diagnostics.eslint,
    diagnostics.codespell,
    diagnostics.flake8,
    diagnostics.jsonlint,
    -- diagnostics.luacheck,
    diagnostics.rubocop,
    diagnostics.yamllint
  },
})
