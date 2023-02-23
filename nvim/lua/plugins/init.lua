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
   "nathom/filetype.nvim", -- Better filetype
   "nvim-lua/plenary.nvim", -- Necessary dependency
   'kyazdani42/nvim-web-devicons', -- Cool icons
   'farmergreg/vim-lastplace', -- Remember last cursor place

   -- Theme
   {
      "EdenEast/nightfox.nvim",
      lazy = false,
      priority = 1000,
      config = function() require('plugins.nightfox') end
   },

   -- Comment lines with "gc"
   {
      'numToStr/Comment.nvim',
      config = true,
      event = "BufEnter"
   },

   -- LSP + Autocomplete
   {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      config = function() require('plugins.lsp') end,
      dependencies = {
         -- LSP Support
         { 'neovim/nvim-lspconfig' }, -- Required
         { 'williamboman/mason.nvim' }, -- Optional
         { 'williamboman/mason-lspconfig.nvim' }, -- Optional

         -- Autocompletion
         { 'hrsh7th/nvim-cmp' }, -- Required
         { 'hrsh7th/cmp-nvim-lsp' }, -- Required
         { 'hrsh7th/cmp-buffer' }, -- Optional
         { 'hrsh7th/cmp-path' }, -- Optional
         { 'saadparwaiz1/cmp_luasnip' }, -- Optional
         { 'hrsh7th/cmp-nvim-lua' }, -- Optional

         -- Snippets
         { 'L3MON4D3/LuaSnip' }, -- Required
         { 'rafamadriz/friendly-snippets' }, -- Optional
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
      config = true,
      event = "BufEnter"
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
   { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',    lazy = true },
   {
      "danimelchor/project.nvim",
      event = "VimEnter",
      config = function ()
         require('project')
      end
   },

   -- Syntax plugin
   {
      'nvim-treesitter/nvim-treesitter',
      config = function() require('plugins.treesitter') end,
      event = "BufEnter"
   },
   "nvim-treesitter/nvim-treesitter-context",

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
      config = true,
      dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
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

   -- Toggle terminals
   { "akinsho/toggleterm.nvim",
      version = '*',
      config = true,
      cmd = "ToggleTerm"
   },

   -- Smooth scrolling
   {
      'declancm/cinnamon.nvim',
      config = function() require('cinnamon').setup() end
   },

   -- Starting page
   {
      "danimelchor/project.nvim",
      config = function()
         require('plugins.project')
      end
   },
   {
      'goolord/alpha-nvim',
      dependencies = {
         'kyazdani42/nvim-web-devicons',
         'danimelchor/project.nvim'
      },
      event = "VimEnter",
      config = function() require('plugins.alpha') end
   },

   -- Copilot
   {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      config = function()
         require("plugins.copilot")
      end,
   },

   -- Markdown previewer
   { 'iamcco/markdown-preview.nvim', cmd = "MarkdownPreview" },
})
