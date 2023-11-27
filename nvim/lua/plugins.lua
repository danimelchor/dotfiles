-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

-- Check if this is work laptop
local is_stripe = require('utils').is_stripe()

-- Monkey patch spawn command to work on remote devbox. Sorry, he wouldn't accept my PR T_T
local spawn = require("lazy.manage.process").spawn
require("lazy.manage.process").spawn = function(cmd, opts)
   opts = opts or {}
   opts.env = vim.tbl_extend("force", opts.env or {}, { GIT_CONFIG_NOSYSTEM = "1" })
   return spawn(cmd, opts)
end

local all_plugins = {
   "nvim-lua/plenary.nvim",        -- Necessary dependency
   'kyazdani42/nvim-web-devicons', -- Cool icons
   'farmergreg/vim-lastplace',     -- Remember last cursor place

   -- Theme
   {
      "catppuccin/nvim",
      lazy = false,
      priority = 1000,
      name = "catppuccin",
      config = function() require('plugins.theme') end
   },

   -- Comment lines with "gc"
   {
      'numToStr/Comment.nvim',
      config = function()
         require("plugins.comment")
      end,
      event = "BufEnter"
   },

   -- Scala dev
   {
      'scalameta/nvim-metals',
      depenencies = { "nvim-lua/plenary.nvim" }
   },

   -- Leap (jump to words using two characters)
   {
      'ggandor/leap.nvim',
      event = "BufEnter",
      config = function() require('plugins.leap') end
   },

   -- Practice plugin
   {
      'ThePrimeagen/vim-be-good',
      cmd = "VimBeGood"
   },

   -- LSP + Autocomplete
   {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      config = function() require('plugins.lsp') end,
      dependencies = {
         -- LSP Support
         { 'neovim/nvim-lspconfig' },             -- Required
         { 'williamboman/mason.nvim' },           -- Optional
         { 'williamboman/mason-lspconfig.nvim' }, -- Optional

         -- Autocompletion
         { 'hrsh7th/nvim-cmp' },         -- Required
         { 'hrsh7th/cmp-nvim-lsp' },     -- Required
         { 'hrsh7th/cmp-buffer' },       -- Optional
         { 'hrsh7th/cmp-path' },         -- Optional
         { 'saadparwaiz1/cmp_luasnip' }, -- Optional
         { 'hrsh7th/cmp-nvim-lua' },     -- Optional

         -- Snippets
         { 'L3MON4D3/LuaSnip' },             -- Required
         { 'rafamadriz/friendly-snippets' }, -- Optional

         { 'simrat39/rust-tools.nvim' },
         is_stripe and { url = "git@git.corp.stripe.com:nms/nvim-lspconfig-stripe.git" } or nil
      }
   },

   -- Null-ls for formatting
   {
      'jose-elias-alvarez/null-ls.nvim',
      config = function() require('plugins.null-ls') end,
      dependencies = {
         "neovim/nvim-lspconfig",
         is_stripe and { url = "git@git.corp.stripe.com:nms/nvim-lspconfig-stripe.git" } or nil
      },
      event = "BufEnter"
   },

   -- Illuminate words like the one you are hovering
   {
      'RRethy/vim-illuminate',
      config = function() require('plugins.illuminate') end,
      event = "BufEnter"
   },

   -- Disable some features for big files
   {
      "LunarVim/bigfile.nvim",
      event = { "FileReadPre", "BufReadPre", "BufEnter" }
   },

   -- Highlight color codes with their code #ff00ff
   {
      'norcalli/nvim-colorizer.lua',
      config = function() require('plugins.colorizer') end,
      event = "VimEnter"
   },

   -- Line at the bottom with status
   {
      'nvim-lualine/lualine.nvim',
      event = "VimEnter",
      dependencies = {
         'kyazdani42/nvim-web-devicons',
         opt = true
      },
      config = function() require('plugins.lualine') end
   },
   'nvim-lua/popup.nvim', -- Necessary dependency

   -- Fuzzy finder for files
   {
      "ibhagwan/fzf-lua",
      config = function() require('plugins.fzf') end,
      cmd = {
         "Files",
         "GFiles",
         "Rg",
      },
   },

   {
      'nvim-telescope/telescope.nvim',
      config = function() require('plugins.telescope') end,
      cmd = "Telescope",
      dependencies = { "telescope-fzf-native.nvim",
         "nathanmsmith/livegrep.nvim",
         { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
   },

   -- Syntax plugin
   {
      'nvim-treesitter/nvim-treesitter',
      config = function() require('plugins.treesitter') end,
      event = "BufEnter",
      dependencies = {
         "nvim-treesitter/nvim-treesitter-context",
         "nvim-treesitter/nvim-treesitter-textobjects",
      }
   },
   'christoomey/vim-tmux-navigator',


   -- Errors an diagnostics
   {
      "folke/trouble.nvim",
      config = function() require('plugins.trouble') end,
      event = "BufEnter"
   },

   -- Autmomatically complete quotes or parens
   {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
   },

   -- File tree
   {
      'nvim-tree/nvim-tree.lua',
      version = "*",
      lazy = false,
      config = function() require('plugins.nvim-tree') end,
   },

   -- Git blame and gutters
   {
      "lewis6991/gitsigns.nvim",
      event = "BufEnter",
      config = function() require('plugins.gitsigns') end
   },
   "rhysd/conflict-marker.vim",

   -- Git diffs
   'sindrets/diffview.nvim',
   'tpope/vim-sleuth', -- Automatically adjust tab size

   -- Copilot
   {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      config = function()
         require("plugins.copilot")
      end,
   },

   -- Markdown previewer
   {
      'iamcco/markdown-preview.nvim',
      lazy = false,
      build = function() vim.fn["mkdp#util#install"]() end
   },

   -- Highlights for
   -- TODO: test
   -- FIX: test
   -- HACK: test
   -- WARN: test
   {
      'folke/todo-comments.nvim',
      config = function() require('todo-comments').setup() end,
      event = "BufEnter"
   },

   -- Surround
   {
      'kylechui/nvim-surround',
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
         require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
         })
      end
   },

   -- Code snipet images
   {
      'narutoxy/silicon.lua',
      config = function() require('plugins.silicon') end,
   },

   -- Navigate between functions, classes, etc.
   {
      'stevearc/aerial.nvim',
      config = function() require('plugins.aerial') end
   },

   -- Better a/i movements
   {
      'echasnovski/mini.ai',
      version = false,
      config = function() require('mini.ai').setup() end,
   },

   -- To switch between single-line and multiline statements
   {
      'echasnovski/mini.splitjoin',
      version = false,
      config = function() require('mini.splitjoin').setup() end,
   },

   -- Move forward and backwards
   {
      'echasnovski/mini.bracketed',
      version = false,
      config = function() require('mini.bracketed').setup() end,
   },

   -- Better increment
   {
      "monaqa/dial.nvim",
      config = function() require('plugins.dial') end,
      event = "BufEnter"
   },

   -- Harpoon
   {
      'ThePrimeagen/harpoon',
      config = function() require('plugins.harpoon') end,
      event = "BufEnter"
   },

   -- Notifications
   {
      'rcarriga/nvim-notify',
      config = function() require('plugins.notify') end,
      event = "BufEnter",
   },
}

require('lazy').setup(all_plugins)
