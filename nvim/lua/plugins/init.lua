local is_stripe = require('utils').is_stripe()

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

  -- Improve at vim
  {
    "m4xshen/hardtime.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim"
    },
    opts = {
      disabled_filetypes = { "oil" },
      restriction_mode = "hint",
      disable_mouse = false,
    }
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

  not is_stripe and {
    dir = "~/projects/mindmap/mindmap.nvim",
    config = function()
      require("mindmap").setup()
      vim.keymap.set("n", "<LEADER>fm", function()
        require("mindmap").fzf_lua()
      end, { desc = "[F]ind in [M]indmap" })
    end,
  } or nil
}
