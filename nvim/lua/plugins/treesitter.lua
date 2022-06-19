local status_ok, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local status_ok_2, nvim_treesitter_parsers = pcall(require, "nvim-treesitter.parsers")
if not status_ok_2 then
  return
end

nvim_treesitter_configs.setup {
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

local parser_config = nvim_treesitter_parsers.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
