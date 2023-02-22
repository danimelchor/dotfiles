local lsp = require('lsp-zero').preset({
  name = 'recommended',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'lua_ls',
  'gopls',
  'jdtls',
})

lsp.nvim_workspace()

-- Autocompletion
local cmp = require('cmp')
local copilot = require('copilot.suggestion')
lsp.setup_nvim_cmp({
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = 'buffer' }
  },
  mapping = cmp.mapping.preset.insert({
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        print("visible")
        cmp.confirm({ select = false })
      elseif copilot.is_visible() then
        copilot.accept()
      else
        fallback()
      end
    end, {
      "i",
    }),
  })
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  float = true,
})
