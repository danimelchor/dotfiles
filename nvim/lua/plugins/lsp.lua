local lsp = require('lsp-zero').preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'lua_ls',
  'gopls',
  'jdtls',
  'rust_analyzer'
})

-- Preferences
lsp.set_preferences({
  suggest_lsp_servers = false
})

-- Autocompletion
local cmp = require('cmp')
local copilot = require('copilot.suggestion')
lsp.setup_nvim_cmp({
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = "path" },
    { name = 'buffer' }
  },
  mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = false })
        elseif copilot.is_visible() then
          copilot.accept()
        else
          fallback()
        end
      end,
      {
        "i",
      }),
  })
})

-- Keybindings
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<LEADER>D', function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set('n', '<LEADER>r', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<LEADER>a', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<LEADER>f', function() vim.lsp.buf.formatting() end, opts)
  vim.keymap.set('n', '<LEADER>w', function()
    vim.lsp.buf.formatting()
    vim.cmd('w')
  end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
end)

-- Custom configs
local lsp_rust = lsp.build_options('rust_analyzer', {})
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

lsp.setup()

require('rust-tools').setup({ server = lsp_rust })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  float = true,
})
