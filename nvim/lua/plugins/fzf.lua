return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      require('fzf-lua').setup({ 'telescope' })
      if vim.fn.executable("fzf") ~= 1 then
        vim.notify("fzf not found. brew install fzf", vim.log.levels.WARN)
      end
    end,
    keys = {
      {
        '<LEADER>lg',
        function()
          local fzf = require('fzf-lua')
          local fzf_lg = require('extensions.fzf_live_grep')
          fzf.fzf_live(fzf_lg.search, fzf_lg.opts())
        end,
        desc = '[L]ive[G]rep'
      },
      { '<LEADER>fh', function() require('fzf-lua').oldfiles({ cwd_only = true }) end,  desc = '[F]ind [H]istory' },
      { '<LEADER>fw', '<cmd>FzfLua grep<CR>',                                           desc = '[F]ind [W]ords' },
      { '<LEADER>fb', '<cmd>FzfLua git_branches<CR>',                                   desc = '[F]ind [B]ranches' },
      { '<LEADER>fs', '<cmd>FzfLua lsp_document_symbols<CR>',                           desc = '[F]ind [S]ymbols' },
      { '<LEADER>fd', '<cmd>FzfLua diagnostics_document<CR>',                           desc = '[F]ind [D]iagnostics' },
      { '<LEADER>km', '<cmd>FzfLua keymaps<CR>',                                        desc = '[K]ey[M]aps' },
      { '<LEADER>fv', '<cmd>FzfLua help_tags<CR>',                                      desc = '[F]ind [V]im help_tags' },
      { '<C-p>',      function() require('fzf-lua').git_files({ cwd_only = true }) end, desc = 'Find project files' },
      { '<LEADER>ff', function() require('fzf-lua').files({ cwd_only = true }) end,     desc = 'Find files' },
    }
  }
}
