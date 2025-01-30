return {
	"nvim-lua/plenary.nvim", -- Necessary dependency
	"nvim-tree/nvim-web-devicons", -- Cool icons
	"farmergreg/vim-lastplace", -- Remember last cursor place
	"nvim-lua/popup.nvim", -- Necessary dependency
	"tpope/vim-sleuth", -- Automatically adjust tab size

	-- Practice plugin
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},

	-- Case sensitive search and replace
	{
		"tpope/vim-abolish",
		event = "BufEnter",
	},

	-- Markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},

	-- Highlights for
	-- TODO(dmelchor): test
	-- FIX: test
	-- HACK: test
	-- WARN: test
	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		opts = {
			search = { pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]] },
			highlight = { pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]] },
		},
	},
}
