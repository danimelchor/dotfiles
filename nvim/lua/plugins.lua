local fn = vim.fn

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile 
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
packer.startup(function(use)
    -- Plugin manager 
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- ** My plugins **

    -- Lazy load plugins
    use {
        'lewis6991/impatient.nvim',
        config = function() require('impatient') end
    }
    use "nathom/filetype.nvim" -- Better filetype
    use "nvim-lua/plenary.nvim" -- Necessary dependency
    use 'kyazdani42/nvim-web-devicons' -- Cool icons
    use "antoinemadec/FixCursorHold.nvim" -- Fix cursor holds
    use 'RRethy/vim-illuminate' -- Illuminate words like the one you are hovering
    use 'farmergreg/vim-lastplace' -- Remember last cursor place

    -- Auto save files
    use {
        "Pocco81/AutoSave.nvim",
        config = function() require("autosave").setup() end
    }

    -- Hightlight color codes with their code #ff00ff
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }
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

    -- LSP Stuff
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function() require('plugins.null-ls') end,
        after = "nvim-lspconfig"
    }

    use {
        'williamboman/nvim-lsp-installer',
        after = "nvim-lspconfig",
        config = function() require("plugins.nvim-lsp-installer") end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function() require('plugins.nvim-lspconfig') end
    }
    use {
        'folke/lsp-colors.nvim',
        'onsails/lspkind-nvim',
        'ray-x/lsp_signature.nvim',
        'tamago324/nlsp-settings.nvim',
    }

    -- Syntax plugin
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end
    }

    -- Autocompletion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        },
        config = function() require('plugins.completion') end,
    }

    -- Autmomatically complete quotes or parens
    use {
        'windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup {} end
    }

    -- TS specific features
    use {
        'p00f/nvim-ts-rainbow',
        'windwp/nvim-ts-autotag',
        'JoosepAlviste/nvim-ts-context-commentstring'
    }

    use 'tpope/vim-commentary' -- Comment out lines
    use 'tpope/vim-surround' -- Wrap selection around chars

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
        'RRethy/nvim-treesitter-endwise',
        config = function()
            require('nvim-treesitter.configs').setup {
                endwise = {
                    enable = true,
                },
            }
        end
    }

    -- Git blame and gutters
    use {
        "lewis6991/gitsigns.nvim",
        config = function() require('gitsigns').setup() end
    }
    use {
        "f-person/git-blame.nvim",
        config = function() require('plugins.git-blame') end
    }
    use "rhysd/conflict-marker.vim"

    -- Git diffs
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use 'tpope/vim-sleuth' -- Automatically adjust tab size
    use 'tpope/vim-repeat' -- . reruns not only native commands

    -- Emmet snippets
    use {
        'mattn/emmet-vim',
        config = function()
            vim.g.user_emmet_leader_key = '<leader>e'
            vim.g.user_emmet_mode = 'nv'
        end,
    }

    -- Toggle terminals
    use {
        "akinsho/toggleterm.nvim",
        tag = 'v1.*',
        config = function() require("plugins.toggleterm") end
    }

    -- Theme
    use "sainnhe/sonokai"
    use "morhetz/gruvbox"

    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

packer.install()
return packer
