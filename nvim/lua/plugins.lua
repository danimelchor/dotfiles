local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

vim.cmd [[packadd packer.nvim]]

-- Install your plugins here
packer.startup(function(use)
    -- Plugin manager
    use "wbthomason/packer.nvim" -- Have packer manage itself

    use "nathom/filetype.nvim" -- Better filetype
    use "nvim-lua/plenary.nvim" -- Necessary dependency
    use 'kyazdani42/nvim-web-devicons' -- Cool icons
    use 'farmergreg/vim-lastplace' -- Remember last cursor place

    -- Comment lines with "gc"
    use {
        'numToStr/Comment.nvim',
        config = function() require("Comment").setup() end
    }

    -- LSP + Autocomplete
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        config = function() require('plugins.lsp') end,
        requires = {
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
    }
    -- Illuminate words like the one you are hovering
    use {
        'RRethy/vim-illuminate',
        config = function() require('plugins.illuminate') end
    }

    -- Highlight color codes with their code #ff00ff
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }

    -- Tabs like Visual Studio Code
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        config = function() require('plugins.bufferline') end
    }

    -- Line at the bottom with status
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require('plugins.lualine') end
    }
    use 'nvim-lua/popup.nvim' -- Necessary dependency

    -- Fuzzy finder for files
    use {
        'junegunn/fzf.vim',
        requires = { 'junegunn/fzf', run = vim.fn['fzf#install'] },
        config = function() require('plugins.fzf') end,
    }
    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup()
        end
    }

    -- Syntax plugin
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end
    }

    -- Autmomatically complete quotes or parens
    use {
        'windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup {} end
    }

    -- File tree
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function() require('plugins.neo-tree') end
    }

    -- Add end keyword for ruby
    use {
        'RRethy/nvim-treesitter-endwise'
    }

    -- Git blame and gutters
    use {
        "lewis6991/gitsigns.nvim",
        config = function() require('plugins.gitsigns') end
    }
    use "rhysd/conflict-marker.vim"

    -- Git diffs
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use 'tpope/vim-sleuth' -- Automatically adjust tab size

    -- Toggle terminals
    use { "akinsho/toggleterm.nvim",
        tag = '*',
        config = function() require("toggleterm").setup() end
    }

    -- Smooth scrolling
    use {
        'declancm/cinnamon.nvim',
        config = function() require('cinnamon').setup() end
    }

    -- Starting page
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('plugins.alpha') end
    }

    -- Copilot
    use {
        "zbirenbaum/copilot.lua",
        config = function()
            require("plugins.copilot")
        end,
    }

    -- Markdown previewer
    use {'iamcco/markdown-preview.nvim'}

    -- Theme
    use "sainnhe/sonokai"
end)

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
