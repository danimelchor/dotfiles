local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  protocol.make_client_capabilities()
)

require'lspconfig'.pyright.setup({
  capabilities = capabilities
})

require'lspconfig'.typeprof.setup({
  capabilities = capabilities
})

require'lspconfig'.html.setup({
  capabilities = capabilities
})

require'lspconfig'.tsserver.setup({
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
})

require'lspconfig'.sumneko_lua.setup({
  capabilities = capabilities
})

require'lspconfig'.diagnosticls.setup({
  capabilities = capabilities,
})

require'lspconfig'.eslint.setup({
  capabilities = capabilities
})

require'lspconfig'.jsonls.setup({
  capabilities = capabilities,
}

require'lspconfig'.vimls.setup({
  capabilities = capabilities,
}))
