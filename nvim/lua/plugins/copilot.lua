 require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
  },
  panel = {
    layout = {
      position = "left",
      ratio = 0.3
    }
  },
  filetypes = {
    yaml = true,
    markdown = true
  },
  server_opts_overrides = {
    settings = {
      advanced = {
        listCount = 10,
        inlineSuggestCount = 1
      }
    }
  }
})
