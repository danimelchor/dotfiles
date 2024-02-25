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

      local lspkind = require('lspkind')
      local formatting = {
        -- Taken from stevearc
        format = lspkind.cmp_format({
          mode = "symbol",
          symbol_map = {
            Copilot = " ",
            Class = "󰆧 ",
            Color = "󰏘 ",
            Constant = "󰏿 ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = "",
            Field = " ",
            File = "󰈙 ",
            Folder = "󰉋 ",
            Function = "󰊕 ",
            Interface = " ",
            Keyword = "󰌋 ",
            Method = "󰊕 ",
            Module = " ",
            Operator = "󰆕 ",
            Property = " ",
            Reference = "󰈇 ",
            Snippet = " ",
            Struct = "󰆼 ",
            Text = "󰉿 ",
            TypeParameter = "󰉿 ",
            Unit = "󰑭",
            Value = "󰎠 ",
            Variable = "󰀫 ",
          },
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
          }
        }),
      }

      cmp.setup({
        formatting = formatting,
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
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      "onsails/lspkind.nvim",

      -- Snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    }
  },

  -- Lua stuff
  'folke/neodev.nvim',

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
          })
        end,
        ['lua_ls'] = function()
          require('lspconfig')['lua_ls'].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                  disable = { "missing-parameters", "missing-fields" }
                },
              },
            }
          })
        end,
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

  -- Automatic docstrings
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = {
      { '<leader>ds', function() require('neogen').generate() end, desc = 'Generate [D]oc[S]tring' },
    }
  }
}
