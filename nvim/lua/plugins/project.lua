local project_nvim = require("project_nvim")
project_nvim.setup({
  detection_methods = { "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ">CodeProjects" }
})
