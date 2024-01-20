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
        '<C-p>',
        function()
          local opts = {
            cwd = vim.fn.getcwd(),
          }
          local fzf = require('fzf-lua')
          local ok = pcall(fzf.git_files, opts)
          if not ok then fzf.files(opts) end
        end,
        desc = 'Find project files'
      },
      {
        '<C-S-p>',
        function()
          local fzf = require('fzf-lua')
          local ok = pcall(fzf.git_files)
          if not ok then fzf.files() end
        end,
        desc = 'Find files'
      },
      { '<LEADER>fw', function() require('fzf-lua').grep() end,                        desc = '[F]ind [W]ords' },
      { '<LEADER>fb', function() require('fzf-lua').git_branches() end,                desc = '[F]ind [B]ranches' },
      { '<LEADER>fs', function() require('fzf-lua').lsp_document_symbols() end,        desc = '[F]ind [S]ymbols' },
      { '<LEADER>fd', function() require('fzf-lua').diagnostics_document() end,        desc = '[F]ind [D]iagnostics' },
      { '<LEADER>km', function() require('fzf-lua').keymaps() end,                     desc = '[K]ey[M]aps' },
      { '<LEADER>fh', function() require('fzf-lua').oldfiles({ cwd_only = true }) end, desc = '[F]ind [H]istory' }
    }
  }
}
