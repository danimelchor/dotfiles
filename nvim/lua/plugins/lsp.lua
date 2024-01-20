local is_stripe = require('utils').is_stripe()

return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local luasnip = require("luasnip")
      local cmp = require('cmp')
      local copilot = require("copilot.suggestion")
      vim.g.copilot_no_tab_map = true

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
              if cmp.visible() then
                cmp.confirm({ select = true })
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
            {
              "i",
              "s"
            }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
              if copilot.is_visible() then
                copilot.accept()
              elseif cmp.visible() then
                cmp.confirm({ select = true })
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

      -- Copilot stuff
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = false
      end)

      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
    dependencies = {
      -- Autocompletion
      'hrsh7th/cmp-nvim-lsp', -- Required
      'hrsh7th/cmp-buffer',   -- Optional
      'hrsh7th/cmp-path',     -- Optional
      'hrsh7th/cmp-nvim-lua', -- Optional

      -- Snippets
      'L3MON4D3/LuaSnip',             -- Required
      'saadparwaiz1/cmp_luasnip',     -- Required
      'rafamadriz/friendly-snippets', -- Optional
    }
  },

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
          'pyright',
          'rust_analyzer',
          'yamlls',
        },
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ['lua_ls'] = function()
          require('lspconfig')['lua_ls'].setup({
            -- capabilities = capabilities,
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

      { 'mrcjkb/rustaceanvim', version = '^3', ft = { 'rust' }, },
      is_stripe and { url = "git@git.corp.stripe.com:nms/nvim-lspconfig-stripe.git" } or nil,
      'folke/neodev.nvim',
    }
  },
}
