return {
  -- Syntax plugin
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local status_ok, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      local status_ok_2, nvim_treesitter_parsers = pcall(require, "nvim-treesitter.parsers")
      if not status_ok_2 then
        return
      end

      require 'treesitter-context'.setup {
        max_lines = 5
      }

      nvim_treesitter_configs.setup {
        ensure_installed = {
          "lua",
          "javascript",
          "typescript",
          "fish",
          "bash",
          "dockerfile",
          "java",
          "ruby",
          "go",
          "html",
          "json",
          "markdown",
          "python",
          "scala",
          "scss",
          "css",
          "regex",
          "vim",
          "yaml",
          "tsx",
          "rust"
        },
        auto_install = true,
        autopairs = {
          enable = true
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true,
        },
      }

      local parser_config = nvim_treesitter_parsers.get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    end,
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    }
  },
}
