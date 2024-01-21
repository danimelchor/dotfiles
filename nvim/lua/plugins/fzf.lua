local is_stripe = require("utils").is_stripe()

local M = {}
M.__index = M
M.results = {}

function M.find_repo_name()
  return vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":p:h:h:t")
end

function M.get_livegrep_url(selected)
  local base = "https://livegrep.corp.stripe.com/view/stripe-internal/"
  local repo = M.find_repo_name()

  -- Remove icon (match until char)
  local icon = selected:match("^[^0-9A-Za-z]+")
  selected = selected:sub(#icon + 1)

  -- Get until first colon
  local path = selected:match("^[^:]+")
  selected = selected:sub(#path + 2)

  -- Get until second colon
  local row = selected:match("^[^:]+")
  selected = selected:sub(#row + 2)

  return base .. repo .. "/" .. path .. "\\#L" .. row
end

function M.live_grep(query)
  M.results = {}
  M.results[query] = {}

  local function f(cb)
    local fzf = require('fzf-lua')

    if not is_stripe then
      return
    end

    if #query < 5 then
      return
    end

    local stripeproxy = os.getenv("HOME") .. "/.stripeproxy"
    local livegrep_args = {}
    if vim.fn.filereadable(stripeproxy) == 1 then
      livegrep_args.url = "http://livegrep.corp.stripe.com/api/v1/search/stripe"
      livegrep_args.raw_curl_opts = "--unix-socket ~/.stripeproxy"
    else
      livegrep_args.url = "http://livegrep-srv.service.envoy:10080/api/v1/search/stripe"
    end

    local query_params = {
      repo = M.find_repo_name(),
      q = query,
    }
    local raw_query_params = ""
    for k, v in pairs(query_params) do
      raw_query_params = "--data-urlencode '" .. k .. "=" .. v .. "' " .. raw_query_params
    end

    local cmd = "curl -s -G " ..
        livegrep_args.raw_curl_opts ..
        " " ..
        raw_query_params ..
        " " ..
        livegrep_args.url ..
        " | jq -r '.results.[] | \"\\(.path):\\(.lno):\\(.bounds[0] + 1):\\(.line)\"'"

    local handle = io.popen(cmd)
    if handle == nil then
      return
    end
    local output = handle:read('*a')
    handle:close()

    local lines = output:gmatch("[^\r\n]+")
    for line in lines do
      local file_line = fzf.make_entry.file(line, { file_icons = true, color_icons = true })
      table.insert(M.results[query], file_line)
      cb(file_line)
    end
  end

  return M.debounce_trailing(f, 500)
end

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
          fzf.fzf_live(M.live_grep, {
            prompt = 'LiveGrep> ',
            previewer = "builtin",
            actions = {
              ['default'] = function(selected, _)
                local url = M.get_livegrep_url(selected[1])
                vim.cmd("silent !open '" .. url .. "'")
              end
            }
          })
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
