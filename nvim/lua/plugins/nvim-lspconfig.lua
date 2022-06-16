local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, protocol = pcall(require, "vim.lsp.protocol")
if not status_ok then
  return
end


local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

local capabilities = cmp_nvim_lsp.update_capabilities(
  protocol.make_client_capabilities()
)

lspconfig.pylsp.setup({
  capabilities = capabilities
})

lspconfig.typeprof.setup({
  capabilities = capabilities
})

lspconfig.html.setup({
  capabilities = capabilities
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
})

lspconfig.sumneko_lua.setup({
  capabilities = capabilities
})

lspconfig.diagnosticls.setup({
  capabilities = capabilities,
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
})

lspconfig.vimls.setup({
  capabilities = capabilities,
})

lspconfig.gopls.setup({
  capabilities = capabilities
})
