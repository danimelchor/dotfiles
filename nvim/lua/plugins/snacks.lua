-- Render code asap
return {
	"folke/snacks.nvim",
	priority = 1000,
	opts = {
		bigfile = {},
		quickfile = {},
		picker = {
		},
	},
	lazy = false,
	keys = {
		{
			"<LEADER>fh",
			function()
				Snacks.picker.recent({ cwd = true })
			end,
			desc = "[F]ind [H]istory",
		},
		{
			"<LEADER>fw",
			function()
				Snacks.picker.grep({ cwd = true })
			end,
			desc = "[F]ind [W]ords"
		},
		{
			"<LEADER>fb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "[F]ind [B]ranches",
		},
		{
			"<LEADER>fs",
			function()
				Snacks.picker.lsp_symbols({ cwd = true })
			end,
			desc = "[F]ind [S]ymbols",
		},
		{
			"<LEADER>fd",
			function()
				Snacks.picker.diagnostics_buffer({ cwd = true })
			end,
			desc = "[F]ind [D]iagnostics",
		},
		{
			"<LEADER>km",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[K]ey[M]aps",
		},
		{
			"<LEADER>fv",
			function()
				Snacks.picker.help()
			end,
			desc = "[F]ind [V]im help_tags",
		},
		{
			"<C-p>",
			function()
				Snacks.picker.git_files({ cwd = true })
			end,
			desc = "Find files in git repo",
		},
		{
			"<LEADER>ff",
			function()
				Snacks.picker.files({ cwd = true })
			end,
			desc = "Find files",
		},
	},
}
