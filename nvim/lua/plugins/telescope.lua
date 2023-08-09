local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

local stripeproxy = os.getenv("HOME") .. "/.stripeproxy"
local livegrep_config = {}
if vim.fn.filereadable(stripeproxy) == 1 then
  livegrep_config.url = "http://livegrep.corp.stripe.com/api/v1/search/stripe"
  livegrep_config.raw_curl_opts = { "--unix-socket", stripeproxy }
else
  livegrep_config.url = "http://livegrep-srv.service.envoy:10080/api/v1/search/stripe"
end

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["?"] = actions.which_key,
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    livegrep = livegrep_config
  }
}

telescope.load_extension('fzf')
telescope.load_extension('livegrep')

-- Fallback for GFiles
local M = {}

M.project_files = function()
  local opts = {}
  local ok = pcall(require "telescope.builtin".git_files, opts)
  if not ok then require "telescope.builtin".find_files(opts) end
end

return M
