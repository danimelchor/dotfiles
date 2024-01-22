local is_stripe = require("utils").is_stripe()

-- @class FzfLiveGrep
-- @field results table
-- @field min_chars number
local FzfLiveGrep = {}
FzfLiveGrep.__index = FzfLiveGrep
FzfLiveGrep.results = {}
FzfLiveGrep.min_chars = 5

-- @param selected string
-- @return string, number, number
function FzfLiveGrep._get_path_from_selected(selected)
  -- Remove icon (match until char)
  local icon = selected:match("^[^0-9A-Za-z]+")
  if icon == nil then
    return nil, nil, nil
  end

  selected = selected:sub(#icon + 1)

  -- Get until first colon
  local path = selected:match("^[^:]+")
  selected = selected:sub(#path + 2)

  -- Get until second colon
  local row = selected:match("^[^:]+")
  selected = selected:sub(#row + 2)
  row = tonumber(row)

  -- Get until third colon
  local col = selected:match("^[^:]+")
  col = tonumber(col) + 1

  return path, row, col
end

-- @param selected string
-- @return string
function FzfLiveGrep.get_livegrep_url(selected)
  local base = "https://livegrep.corp.stripe.com/view/stripe-internal/"
  local repo = FzfLiveGrep.find_repo_name()
  local path, row = FzfLiveGrep._get_path_from_selected(selected)
  if path == nil then
    return nil
  end
  return base .. repo .. "/" .. path .. "\\#L" .. row
end

-- @return Previewer
function FzfLiveGrep.previewer()
  local builtin = require("fzf-lua.previewer.builtin")

  local MyPreviewer = builtin.base:extend()

  -- @param o table
  -- @param opts table
  -- @param fzf_win table
  function MyPreviewer:new(o, opts, fzf_win)
    MyPreviewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
  end

  -- @param selected string
  -- @return nil
  function MyPreviewer:populate_preview_buf(selected)
    local tmpbuf = self:get_tmp_buffer()

    local path, lno = FzfLiveGrep._get_path_from_selected(selected)
    local obj = nil
    for _, o in ipairs(FzfLiveGrep.results) do
      if o.path == path and o.lno == lno then
        obj = o
        break
      end
    end

    if obj == nil then
      return
    end

    local lines = {}

    -- Add context lines
    table.insert(lines, "...")
    for _, line in ipairs(obj.context_before) do
      table.insert(lines, 2, line)
    end
    local lineNum = #lines + 1
    table.insert(lines, obj.line)
    for _, line in ipairs(obj.context_after) do
      table.insert(lines, line)
    end
    table.insert(lines, "...")

    -- Add line to buffer
    vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, lines)

    -- Highlight search line
    vim.api.nvim_buf_add_highlight(tmpbuf, -1, "Search", lineNum - 1, 0, -1)

    self:set_preview_buf(tmpbuf)
    self.win:update_scrollbar()
  end

  -- @return table
  function MyPreviewer:gen_winopts()
    local new_winopts = {
      wrap   = false,
      number = false
    }
    return vim.tbl_extend("force", self.winopts, new_winopts)
  end

  return MyPreviewer
end

-- @return string
function FzfLiveGrep.find_repo_name()
  return vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":p:h:h:t")
end

-- @param query string
-- @return function
function FzfLiveGrep.search(query)
  -- @param cb function
  -- @return nil
  return function(cb)
    local stripeproxy = os.getenv("HOME") .. "/.stripeproxy"
    local url = ""
    local raw = {}

    if not is_stripe then
      cb("Not on Stripe")
      return
    end

    if #query < FzfLiveGrep.min_chars then
      cb("Query must be at least 3 characters")
      return
    end

    if vim.fn.filereadable(stripeproxy) == 1 then
      url = "http://livegrep.corp.stripe.com/api/v1/search/stripe"
      raw = { "--unix-socket", stripeproxy }
    else
      url = "http://livegrep-srv.service.envoy:10080/api/v1/search/stripe"
    end

    local params = {
      repo = FzfLiveGrep.find_repo_name(),
      q = query,
      regex = "true",
      context = "true",
    }

    -- Use plenary curl
    local curl = require("plenary.curl")
    local res = curl.get({
      url = url,
      accept = "application/json",
      query = params,
      raw = raw,
    })
    local json = vim.fn.json_decode(res.body) or {}
    local results = json.results or {}

    local clean_results = {}
    for _, obj in ipairs(results) do
      local clean_obj = {
        path = obj.path,
        lno = obj.lno,
        col = obj.bounds[1],
        context_before = obj.context_before,
        context_after = obj.context_after,
        line = obj.line,
      }

      table.insert(clean_results, clean_obj)

      -- Format line
      local line = clean_obj.path .. ":" .. clean_obj.lno .. ":" .. clean_obj.col .. ":" .. clean_obj.line
      local file_line = require("fzf-lua").make_entry.file(line, {
        file_icons = true,
        color_icons = true,
      })
      cb(file_line)
    end

    FzfLiveGrep.results = clean_results
  end
end

-- @param selected string
function FzfLiveGrep.open_browser(selected)
  local url = FzfLiveGrep.get_livegrep_url(selected[1])
  if url == nil then
    return
  end
  vim.cmd("silent !open '" .. url .. "'")
end

-- @param selected string
function FzfLiveGrep.open_local(selected)
  local path, row, col = FzfLiveGrep._get_path_from_selected(selected[1])
  local repo = FzfLiveGrep.find_repo_name()

  -- ~/stripe/{repo}/{path}
  local full = os.getenv("HOME") .. "/stripe/" .. repo .. "/" .. path

  vim.cmd("e " .. full)

  -- Move cursor to line
  local row_str = tostring(row)
  vim.cmd(row_str)

  -- Move cursor to column
  local col_str = tostring(col)
  vim.cmd("normal " .. col_str .. "|")
end

-- @param opts table
function FzfLiveGrep.opts(opts)
  local defaults = {
    prompt = 'LiveGrep> ',
    previewer = FzfLiveGrep.previewer(),
    actions = {
      ['default'] = FzfLiveGrep.open_browser,
      ['ctrl-e'] = FzfLiveGrep.open_local,
    }
  }
  opts = opts or {}
  FzfLiveGrep.min_chars = opts.min_chars or FzfLiveGrep.min_chars
  defaults = vim.tbl_extend("force", defaults, opts)
  return defaults
end

return FzfLiveGrep
