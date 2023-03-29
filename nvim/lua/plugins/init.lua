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

require('lazy').setup({
   "nathom/filetype.nvim",         -- Better filetype
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

         { 'simrat39/rust-tools.nvim' }
      }
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
      config = function() require('colorizer').setup() end,
      event = "VimEnter"
   },

   -- Tabs like Visual Studio Code
   {
      'akinsho/bufferline.nvim',
      version = "v3.*",
      event = "BufEnter",
      config = function() require('plugins.bufferline') end
   },

   -- Line at the bottom with status
   {
      'nvim-lualine/lualine.nvim',
      event = "VimEnter",
      dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function() require('plugins.lualine') end
   },
   'nvim-lua/popup.nvim', -- Necessary dependency

   -- Fuzzy finder for files
   {
      'junegunn/fzf.vim',
      config = function() require('plugins.fzf') end,
      cmd = {
         "Files",
         "GFiles",
         "Rg",
      },
      dependencies = {
         'junegunn/fzf'
      }
   },
   {
      'nvim-telescope/telescope.nvim',
      config = function() require('plugins.telescope') end,
      cmd = "Telescope",
      dependencies = { "telescope-fzf-native.nvim" },
   },
   { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true },

   -- Syntax plugin
   {
      'nvim-treesitter/nvim-treesitter',
      config = function() require('plugins.treesitter') end,
      event = "BufEnter"
   },
   "nvim-treesitter/nvim-treesitter-context",
   'christoomey/vim-tmux-navigator',

   -- Errors and diagnostics
   {
      "folke/trouble.nvim",
      config = true,
      cmd = "Trouble"
   },

   -- Autmomatically complete quotes or parens
   {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
   },

   -- File tree
   {
      'nvim-neo-tree/neo-tree.nvim',
      branch = "v2.x",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "kyazdani42/nvim-web-devicons",
         "MunifTanjim/nui.nvim",
      },
      lazy = false,
      config = function() require('plugins.neo-tree') end,
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

   -- Smooth scrolling
   {
      'declancm/cinnamon.nvim',
      config = function() require('cinnamon').setup() end
   },

   -- Copilot
   {
      "github/copilot.vim",
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
   }
})
