local function configureTheme(name)
  vim.cmd("colorscheme " .. name)

  local function onBufEnter()
    vim.opt.termguicolors = true
    vim.wo.fillchars = 'eob: '
    vim.cmd("silent! syntax enable")
    vim.cmd("silent! hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd("silent! hi EndOfBuffer guibg=NONE ctermbg=NONE")

    -- Line numbers highlight fg
    vim.cmd("silent! hi LineNr guifg=#b4befe")
  end

  local augroup = vim.api.nvim_create_augroup("ThemeConfig", {})
  vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    callback = onBufEnter,
  })
end

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
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
    'brenoprata10/nvim-highlight-colors',
    config = true,
    event = "BufEnter"
  },
}
