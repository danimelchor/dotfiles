local if_nil = vim.F.if_nil
local fnamemodify = vim.fn.fnamemodify

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local status_ok2, startify = pcall(require, "alpha.themes.startify")
if not status_ok2 then
  return
end

local function alpha_button(sc, txt)
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>")
  if vim.g.mapleader then
    sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader)
  end
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 90,
      align_shortcut = "right",
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

local function section_header(title)
  -- Upercase
  title = title:upper()
  return {
    type = "text",
    val = title,
    opts = {
      position = "center",
      text = title,
      width = 90,
      hl = "TSStrong",
    },
  }
end

local function file_button(idx, proj_name, long_fn, short_fn)
  local full_text = "  " .. proj_name .. " (" .. short_fn .. ")"
  local button = {
    type = "button",
    val = full_text,
    on_press = function()
      local cmd = "<cmd>e " .. long_fn .. " | cd %:p:h<cr>"
      local key = vim.api.nvim_replace_termcodes(cmd .. "<Ignore>", true, false, true)
      vim.api.nvim_feedkeys(key, "t", false)
    end,
    opts = {
      text = full_text,
      position = "center",
      shortcut = "[" .. idx .. "]",
      cursor = 5,
      width = 90,
      align_shortcut = "right",
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
  local fb_hl = {}
  local fn_start = full_text:match("^[^(]*")
  if fn_start ~= nil then
    table.insert(fb_hl, { "DashboardCenter", 0, #fn_start })
    table.insert(fb_hl, { "Comment", #fn_start, #full_text })
  end
  button.opts.hl = fb_hl
  return button
end

local function get_project_name(fn)
  -- Split by /
  local split_fn = vim.split(fn, "/")

  -- Traverse backwards through split_fn
  local short_fn = ""
  for i = #split_fn, 1, -1 do
    short_fn = split_fn[i]
    if short_fn ~= "" then
      break
    end
  end
  return short_fn
end

local function get_recent()
  local project_nvim = require("project_nvim")
  local recent_projects = project_nvim.get_recent_projects_sync()

  local tbl = {}

  -- Iterate backwards through 10 most recent projects
  for i = #recent_projects, math.max(#recent_projects - 9, 1), -1 do
    local fn = recent_projects[i]
    local proj_name = get_project_name(fn)
    local short_fn = fnamemodify(fn, ":~:.")
    local idx = #recent_projects - i + 1
    local file_button_el = file_button(
      tostring(idx),
      proj_name,
      fn,
      short_fn
    )

    table.insert(tbl, file_button_el)
  end

  return tbl
end


alpha.setup {
  layout = {
    { type = "padding", val = vim.fn.floor(vim.fn.winheight(0) * 0.15) },
    {
      type = "text",
      val = {
        "██████  ███    ███ ███████ ██       ██████ ██   ██  ██████  ██████",
        "██   ██ ████  ████ ██      ██      ██      ██   ██ ██    ██ ██   ██",
        "██   ██ ██ ████ ██ █████   ██      ██      ███████ ██    ██ ██████",
        "██   ██ ██  ██  ██ ██      ██      ██      ██   ██ ██    ██ ██   ██",
        "██████  ██      ██ ███████ ███████  ██████ ██   ██  ██████  ██   ██",
      },
      opts = { position = "center", hl = "DashboardShortcut" },
    },
    { type = "padding", val = 5 },
    section_header("Recent Projects"),
    { type = "padding", val = 1 },
    {
      type = "group",
      val = get_recent(),
      opts = { spacing = 1 },
    },
    { type = "padding", val = 2 },
    section_header("File Operations"),
    { type = "padding", val = 1 },
    {
      type = "group",
      val = {
        alpha_button("LDR f f", "  Find File  "),
        alpha_button("LDR f p", "  Recent Projects  "),
        alpha_button("LDR f h", "  File History  "),
        alpha_button("LDR f w", "  Find Word  "),
        alpha_button("LDR f n", "  New File  "),
        alpha_button("LDR f b", "  Switch Branches  "),
      },
      opts = { spacing = 1 },
    }
  },
  opts = {},
}
