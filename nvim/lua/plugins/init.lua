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

-- Monkey patch spawn command to work on remote devbox. Sorry, he wouldn't accept my PR T_T
local spawn = require("lazy.manage.process").spawn
require("lazy.manage.process").spawn = function(cmd, opts)
   opts = opts or {}
   opts.env = vim.tbl_extend("force", opts.env or {}, { GIT_CONFIG_NOSYSTEM = "1" })
   return spawn(cmd, opts)
end

require('lazy').setup({
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
         { url = "git@git.corp.stripe.com:nms/nvim-lspconfig-stripe.git" }
      }
   },

   -- Null-ls for formatting
   {
      'jose-elias-alvarez/null-ls.nvim',
      config = function() require('plugins.null-ls') end,
      dependencies = { "neovim/nvim-lspconfig", { url = "git@git.corp.stripe.com:nms/nvim-lspconfig-stripe.git" } },
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
         { url = "git@git.corp.stripe.com:stevearc/pay-status.nvim.git" }, -- Statusline integration for pay up:status
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
      depenencies = {
         "nvim-treesitter/nvim-treesitter-context",
         "nvim-treesitter/nvim-treesitter-textobjects",
      }
   },
   'christoomey/vim-tmux-navigator',

   -- Useful :StripeOwner command
   {
      url = "git@git.corp.stripe.com:dbalatero/stripe-code-owner.nvim.git",
      cmd = "StripeOwner",
      config = function()
         vim.api.nvim_create_user_command("StripeOwner", require("stripe-code-owner").showOverlay, {})
      end,
   },

   -- Dagger window
   {
      url = "git@git.corp.stripe.com:stevearc/dagger.nvim.git",
      ft = "java",
      config = function()
         local dagger = require("dagger")
         dagger.setup()
         vim.keymap.set("n", "<leader>dt", dagger.toggle, { desc = "[D]agger [T]oggle" })
         vim.keymap.set("n", "<leader>do", dagger.open, { desc = "[D]agger [O]pen" })
         vim.keymap.set("n", "<leader>dc", dagger.close, { desc = "[D]agger [C]lose" })
      end,
   },

   -- Bazel tasks and fzf integration
   {
      url = "git@git.corp.stripe.com:stevearc/bazel.nvim.git",
      config = function()
         local bazel = require("bazel")
         bazel.setup()
         vim.keymap.set("n", "<leader>bp", function()
            bazel.select_project("intellij/*.bazelproject")
         end, { desc = "[B]azel [P]ick project" })
         vim.keymap.set("n", "<leader>bc", function()
            bazel.set_project(nil)
         end, { desc = "[B]azel [C]lear project" })
         vim.keymap.set("n", "<leader>fp", bazel.fzf_project_files, { desc = "[F]ind [P]roject files" })
      end,
   },

   -- Task runner
   {
      "stevearc/overseer.nvim",
      opts = {
         templates = { "builtin", "bazel" },
         default_neotest = {
            { "on_complete_notify", on_change = true },
            "default",
         },
      },
      config = function(_, opts)
         require("overseer").setup(opts)
         vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<CR>", { desc = "[O]verseer [T]oggle" })
         vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<CR>", { desc = "[O]verseer [R]un" })
         vim.keymap.set("n", "<leader>oq", "<cmd>OverseerQuickAction<CR>", { desc = "[O]verseer [Q]uick action" })
         vim.keymap.set("n", "<leader>oa", "<cmd>OverseerTaskAction<CR>", { desc = "[O]verseer task [A]ction" })
      end,
   },

   -- Testing framework
   {
      "nvim-neotest/neotest",
      dependencies = {
         "haydenmeade/neotest-jest",
         { url = "git@git.corp.stripe.com:stevearc/neotest-pay-test.git" },
         "nvim-lua/plenary.nvim",
         "stevearc/overseer.nvim",
      },
      config = function()
         local neotest_jest = require("neotest-jest")
         local neotest = require("neotest")
         neotest.setup({
            adapters = {
               neotest_jest({
                  cwd = neotest_jest.root,
               }),
               require("neotest-pay-test")(),
            },
            discovery = {
               enabled = false,
            },
            consumers = {
               overseer = require("neotest.consumers.overseer"),
            },
            icons = {
               passed = " ",
               running = " ",
               failed = " ",
               unknown = " ",
               running_animated = vim.tbl_map(function(s)
                  return s .. " "
               end, { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }),
            },
            output = {
               open_on_run = false,
            },
            quickfix = {
               open = false,
            },
         })
         vim.keymap.set("n", "<leader>tf", function()
            neotest.run.run({ vim.api.nvim_buf_get_name(0) })
         end, { desc = "[T]est [F]ile" })
         vim.keymap.set("n", "<leader>tn", function()
            neotest.run.run({})
         end, { desc = "[T]est [N]earest" })
         vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { desc = "[T]est [L]ast" })
         vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "[T]est toggle [S]ummary" })
         vim.keymap.set("n", "<leader>to", function()
            neotest.output.open({ short = true })
         end, { desc = "[T]est [O]utput" })
      end,
   },

   -- Errors an diagnostics
   {
      "folke/trouble.nvim",
      config = function() require('plugins.trouble') end,
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
      branch = "v3.x",
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
   },

   -- Better a/i movements
   {
      'echasnovski/mini.ai',
      version = false,
      config = function() require('mini.ai').setup() end,
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
})
