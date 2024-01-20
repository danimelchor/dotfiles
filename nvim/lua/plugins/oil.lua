return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('oil').setup({
      })

      vim.api.nvim_set_keymap('n', '<Leader>n', '<Cmd>Oil<CR>', { noremap = true, silent = true, desc = 'Open Oil' })
    end,
  }
}
