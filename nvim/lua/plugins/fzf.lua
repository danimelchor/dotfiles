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
      {
        '<LEADER>lg',
        function()
          local fzf = require('fzf-lua')
          local fzf_lg = require('extensions.fzf_live_grep')
          fzf.fzf_live(fzf_lg.search, fzf_lg.opts)
        end,
        desc = '[L]ive[G]rep'
      },
      {
        '<LEADER>t',
        function()
          require 'fzf-lua'.fzf_live("rg --column --color=always -- <query>", {
            fn_transform = function(x)
              return require 'fzf-lua'.make_entry.file(x, { file_icons = true, color_icons = true })
            end,
          })
        end,
        desc = '[T]ext'
      },
      { '<LEADER>fh', function() require('fzf-lua').oldfiles({ cwd_only = true }) end, desc = '[F]ind [H]istory' },
      { '<LEADER>fw', '<cmd>FzfLua grep<CR>',                                          desc = '[F]ind [W]ords' },
      { '<LEADER>fb', '<cmd>FzfLua git_branches<CR>',                                  desc = '[F]ind [B]ranches' },
      { '<LEADER>fs', '<cmd>FzfLua lsp_document_symbols<CR>',                          desc = '[F]ind [S]ymbols' },
      { '<LEADER>fd', '<cmd>FzfLua diagnostics_document<CR>',                          desc = '[F]ind [D]iagnostics' },
      { '<LEADER>km', '<cmd>FzfLua keymaps<CR>',                                       desc = '[K]ey[M]aps' },
      { '<LEADER>fv', '<cmd>FzfLua help_tags<CR>',                                     desc = '[F]ind [V]im help_tags' }
    }
  }
}
