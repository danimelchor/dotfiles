local is_stripe = require("config.utils").is_stripe()

return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		version = "*",
		config = function()
			require("blink.cmp").setup({
				keymap = {
					["<Tab>"] = { "accept", "fallback" },
					["<C-k>"] = { "select_prev" },
					["<C-j>"] = { "select_next" },
					["<Up>"] = {},
					["<Down>"] = {},
				},
				appearance = {
					use_nvim_cmp_as_default = true,
				},
				completion = {
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 300,
						window = {
							border = "single",
							winhighlight =
							"Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
						},
					},
					list = {
						selection = {
							auto_insert = false,
						},
					},
					menu = {
						border = "single",
					},
				},
				signature = {
					enabled = true,
					window = { border = "single" },
				},
				cmdline = {
					enabled = true,
					keymap = { preset = 'inherit' },
					completion = {
						menu = { auto_show = true },
					},
				},
			})

			local ok, copilot = pcall(require, "copilot.suggestion")
			if ok then
				vim.g.copilot_no_tab_map = true
				vim.keymap.set("i", "<S-Tab>", function()
					if copilot.is_visible() then
						copilot.accept()
					end
				end, { desc = "Accept Copilot Suggestions" })
			end
		end,
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
