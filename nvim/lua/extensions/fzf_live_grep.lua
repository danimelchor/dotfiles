local is_stripe = require("utils").is_stripe()

local M = {}
M.__index = M
M.results = {}

function M._get_path_from_selected(selected)
  -- Remove icon (match until char)
  local icon = selected:match("^[^0-9A-Za-z]+")
  selected = selected:sub(#icon + 1)

  -- Get until first colon
  local path = selected:match("^[^:]+")
  selected = selected:sub(#path + 2)

  -- Get until second colon
  local row = selected:match("^[^:]+")
  selected = selected:sub(#row + 2)

  return path, row
end

function M.get_livegrep_url(selected)
  local base = "https://livegrep.corp.stripe.com/view/stripe-internal/"
  local repo = M.find_repo_name()

  local path, row = M._get_path_from_selected(selected)

  return base .. repo .. "/" .. path .. "\\#L" .. row
end

function M.previewer()
  local builtin = require("fzf-lua.previewer.builtin")

  -- Inherit from "base" instead of "buffer_or_file"
  local MyPreviewer = builtin.base:extend()

  function MyPreviewer:new(o, opts, fzf_win)
    MyPreviewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
  end

  function MyPreviewer:populate_preview_buf(selected)
    local tmpbuf = self:get_tmp_buffer()

    local lines = {}
    local path = M._get_path_from_selected(selected)
    local obj = nil
    for _, o in ipairs(M.results) do
      if o.path == path then
        obj = o
        break
      end
    end

    if obj == nil then
      return
    end

    -- Add lines before line
    local context_before = obj.context_before
    for _, line in ipairs(context_before) do
      if line ~= "" then
        table.insert(lines, line)
      end
    end

    -- Add actual line
    table.insert(lines, obj.line)

    -- Add lines after line
    local context_after = obj.context_after
    for _, line in ipairs(context_after) do
      if line ~= "" then
        table.insert(lines, line)
      end
    end

    -- Add line to buffer
    vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, lines)

    self:set_preview_buf(tmpbuf)
    self.win:update_scrollbar()
  end

  -- Disable line numbering and word wrap
  function MyPreviewer:gen_winopts()
    local new_winopts = {
      wrap   = false,
      number = false
    }
    return vim.tbl_extend("force", self.winopts, new_winopts)
  end

  return MyPreviewer
end

function M.find_repo_name()
  return vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":p:h:h:t")
end

function M.live_grep(query)
  return function(cb)
    local fzf = require('fzf-lua')

    if not is_stripe then
      cb("Not in Stripe laptop")
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
        " | jq -c -r '.results | map({path,lno,col: .bounds[0],context_before,context_after,line})'"

    local handle = io.popen(cmd)
    if handle == nil then
      return
    end
    local output = handle:read('*a')
    handle:close()

    local json = vim.fn.json_decode(output) or {}
    M.results = json

    for _, obj in ipairs(json) do
      local line = obj.path .. ":" .. obj.lno .. ":" .. obj.col .. " " .. obj.line
      local file_line = fzf.make_entry.file(line, { file_icons = true, color_icons = true })
      cb(file_line)
    end
  end
end

function M.open(selected)
  local url = M.get_livegrep_url(selected[1])
  vim.cmd("silent !open '" .. url .. "'")
end

M.opts = {
  prompt = 'LiveGrep> ',
  previewer = M.previewer(),
  actions = {
    ['default'] = M.fzf_lg.open
  }
}
