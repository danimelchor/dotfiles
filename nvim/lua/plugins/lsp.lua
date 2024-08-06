local is_stripe = require('utils').is_stripe()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  float = {
    source = "always",
    border = "rounded",
    focusable = false,
  },
  severity_sort = true,
})

local toggle_inlay_hint = function()
  local is_enabled = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not is_enabled)
end

-- LSP
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<LEADER>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<LEADER>r', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<LEADER>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<LEADER>f', function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', 'dh', toggle_inlay_hint, opts)

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end
end

return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("neodev").setup()
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
          'ruff',
          'basedpyright',
          'yamlls',
          'svelte',
        },
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ['lua_ls'] = function()
          require('lspconfig')['lua_ls'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                  disable = { "missing-parameters", "missing-fields" }
                },
                hint = { enable = true },
                telemetry = { enable = false },
              },
            }
          })
        end,
        ['gopls'] = function()
          require('lspconfig')['gopls'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              gopls = {
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            }
          })
        end,
        ['basedpyright'] = function()
          require('lspconfig')['basedpyright'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ['tsserver'] = function()
          local inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = false,
          }
          require('lspconfig')['tsserver'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              javascript = {
                inlayHints = inlayHints,
              },
              typescript = {
                inlayHints = inlayHints,
              },
            },
          })
        end
      })

      if is_stripe then
        -- Setup 'payserver_sorbet'
        require("lspconfig_stripe")
        require("lspconfig")['payserver_sorbet'].setup({})
      end
    end,
    dependencies = {
      -- LSP Support
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      is_stripe and { url = "git@git.corp.stripe.com:nms/nvim-lspconfig-stripe.git" } or nil,
    }
  },

  -- Rust config
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = { 'rust' },
  },
}
