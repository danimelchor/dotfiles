local is_stripe = require('utils').is_stripe()

require("luasnip.loaders.from_vscode").lazy_load()

-- Autocompletion
vim.g.copilot_no_tab_map = true
local cmp = require('cmp')
cmp.setup({
  completion = {
    completeopt = 'menu,menuone',
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = "path" },
    { name = 'buffer' }
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Tab>'] = cmp.mapping(function(fallback)
        local copilot = require("copilot.suggestion")
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif copilot.is_visible() then
          copilot.accept()
        else
          fallback()
        end
      end,
      {
        "i",
        "s"
      }),
  },
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'tsserver',
    'lua_ls',
    'bashls',
    'cssls',
    'eslint',
    'html',
    'jsonls',
    'pyright',
    'rust_analyzer',
    'yamlls',
  },
})
require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
    })
  end,
  ['lua_ls'] = function()
    require('lspconfig')['lua_ls'].setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      }
    })
  end
})
require("fidget").setup({
  notification = {
    poll_rate = 3,
    window = {
      winblend = 0,
    }
  },
})

if is_stripe then
  -- Setup 'payserver_sorbet'
  require("lspconfig_stripe")
  require("lspconfig")['payserver_sorbet'].setup({})
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  float = true,
})


-- Autoformatting
local FormatGroup = vim.api.nvim_create_augroup("FormatAutogroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = FormatGroup,
  pattern = { "*.js", "*.ts", "*.tsx", "*.jsx", "*.py", "*.lua" },
  callback = function()
    vim.cmd("silent! lua vim.lspconfig.buf.format()")
  end,
})
