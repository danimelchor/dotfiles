local is_stripe = require("config.utils").is_stripe()

return {
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			local copilot = require("copilot.suggestion")
			vim.g.copilot_no_tab_map = true

			local lspkind = require("lspkind")
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
					},
				}),
			}

			cmp.setup({
				preselect = cmp.PreselectMode.Item,
				formatting = formatting,
				completion = {
					completeopt = "menu,menuone,noinsert,preview",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if copilot.is_visible() then
							copilot.accept()
						else
							fallback()
						end
					end, {
						"i",
						"s",
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
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",

			-- Snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
		enabled = false,
	},

	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		version = "v0.*",
		opts = {
			keymap = {
				["<Tab>"] = { "accept", "fallback" },
				["<C-k>"] = { "select_prev" },
				["<C-j>"] = { "select_next" },
				["<S-k>"] = { "show_documentation" },
			},
			highlight = {
				use_nvim_cmp_as_default = true,
			},
			nerd_font_variant = "normal",
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			trigger = {
				signature_help = {
					enabled = true,
				},
			},
			windows = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 300,
					update_delay_ms = 50,
				},
			},
		},
	},

	-- Automatic docstrings
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		keys = {
			{
				"<leader>ds",
				function()
					require("neogen").generate()
				end,
				desc = "Generate [D]oc[S]tring",
			},
		},
	},

	-- Lua stuff
	"folke/neodev.nvim",
}
