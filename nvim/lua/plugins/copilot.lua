require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
  },
  panel = {
    layout = {
      position = "right",
      ratio = 0.3
    }
  },
  server_opts_overrides = {
    settings = {
      advanced = {
        listCount = 10,
        inlineSuggestCount = 1
      }
    }
  },
  filetypes = {
    yaml = true,
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = true,
  }
})
