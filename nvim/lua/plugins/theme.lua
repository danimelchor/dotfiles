function configureTheme(name)
  vim.cmd("colorscheme " .. name)

  vim.opt.termguicolors = true
  vim.cmd("silent! syntax enable")
  vim.cmd("silent! hi Normal guibg=NONE ctermbg=NONE")
  vim.cmd("silent! hi EndOfBuffer guibg=NONE ctermbg=NONE")

  -- Line numbers highlight fg
  vim.cmd("silent! hi LineNr guifg=#b4befe")
end

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require('catppuccin').setup()
    end
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      configureTheme("rose-pine")
    end
  },

  -- Illuminate words like the one you are hovering
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        filetypes_denylist = {
          'NvimTree',
        }
      })
    end,
    event = "BufEnter"
  },

  -- Highlight color codes with their code #ff00ff
  {
    'norcalli/nvim-colorizer.lua',
    config = true,
    event = "VimEnter"
  },
}
