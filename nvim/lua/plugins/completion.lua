local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.select_next_item(),,
    ['<S-Tab>'] = cmp.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  },
})
