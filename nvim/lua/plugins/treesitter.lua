require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "c",
      "lua",
      "typescript",
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
      "tsx"
  },
  autopairs = {
    enable = true
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true
  },
  context_commentstring = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
  },
  endwise = {
    enable = true
  },
  autotag = {
    enable = true
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
