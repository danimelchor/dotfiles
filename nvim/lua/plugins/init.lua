return {
  "nvim-lua/plenary.nvim",        -- Necessary dependency
  'kyazdani42/nvim-web-devicons', -- Cool icons
  'farmergreg/vim-lastplace',     -- Remember last cursor place
  'nvim-lua/popup.nvim',          -- Necessary dependency
  'christoomey/vim-tmux-navigator',
  'tpope/vim-sleuth',             -- Automatically adjust tab size

  -- Practice plugin
  {
    'ThePrimeagen/vim-be-good',
    cmd = "VimBeGood"
  },

  -- Disable some features for big files
  {
    "LunarVim/bigfile.nvim",
    event = { "FileReadPre", "BufReadPre", "BufEnter" }
  },

  -- Markdown previewer
  {
    'iamcco/markdown-preview.nvim',
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- Highlights for
  -- TODO: test
  -- FIX: test
  -- HACK: test
  -- WARN: test
  {
    'folke/todo-comments.nvim',
    config = true,
    event = "BufEnter"
  },
}
