require('cloak').setup({
  enabled = true,
  cloak_character = '*',
  patterns = {
    {
      file_pattern = {
        ".env*",
        "wrangler.toml",
        ".dev.vars",
      },
      cloak_pattern = '=.+',
    },
  },
})
