local lsp = require('lsp-zero').preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'lua_ls',
  'jdtls',
  'bashls',
  'cssls',
  'eslint',
  'graphql',
  'html',
  'jsonls',
  'pyright',
  'rust_analyzer',
  'yamlls',
})

-- Preferences
lsp.set_preferences({
  suggest_lsp_servers = false
})

-- Autocompletion
local cmp = require('cmp')
vim.g.copilot_no_tab_map = true
lsp.setup_nvim_cmp({
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = "path" },
    { name = 'buffer' }
  },
  mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), ['<Tab>'] = cmp.mapping(function(fallback)
        local copilot_keys = vim.fn['copilot#Accept']()
        if cmp.visible() then
          cmp.confirm({ select = false })
        elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
          vim.api.nvim_feedkeys(copilot_keys, 'i', true)
        else
          fallback()
        end
      end,
      {
        "i",
        "s"
      }),
  }
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
  vim.keymap.set('n', '<LEADER>f', function() vim.lsp.buf.formatting({ async = true }) end, opts)
  vim.keymap.set('n', '<LEADER>w', function()
    vim.lsp.buf.formatting()
    vim.cmd('w')
  end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
end)

lsp.setup()

-- Setup 'payserver_sorbet'
require("lspconfig_stripe")
require("lspconfig")['payserver_sorbet'].setup({
  capabilities = lsp.capabilities,
  on_attach = lsp.on_attach,
})

-- Metals
local metals_lsp = lsp.build_options('metals', {})
local metals_config = require('metals').bare_config()

metals_config.capabilities = metals_lsp.capabilities

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  float = true,
})
