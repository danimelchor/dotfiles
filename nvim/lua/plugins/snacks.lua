-- Render code asap
local get_opts = function()
	return { cwd = vim.uv.cwd() }
end

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
				Snacks.picker.recent(get_opts())
			end,
			desc = "[F]ind [H]istory",
		},
		{
			"<LEADER>fw",
			function()
				Snacks.picker.grep(get_opts())
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
				Snacks.picker.lsp_symbols(get_opts())
			end,
			desc = "[F]ind [S]ymbols",
		},
		{
			"<LEADER>fd",
			function()
				Snacks.picker.diagnostics_buffer(get_opts())
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
				Snacks.picker.git_files(get_opts())
			end,
			desc = "Find files in git repo",
		},
		{
			"<LEADER>ff",
			function()
				Snacks.picker.files(get_opts())
			end,
			desc = "Find files",
		},
	},
}
