local project_nvim = require("project_nvim")
project_nvim.setup({
  detection_methods = { "patterns" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "^CodeProjects" }
})
