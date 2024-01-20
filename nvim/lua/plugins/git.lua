return {
  -- Git blame and gutters
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = function()
      local status_ok, gitsigns = pcall(require, "gitsigns")
      if not status_ok then
        return
      end

      gitsigns.setup({
        current_line_blame_formatter = '<author> - <author_time:%Y-%m-%d> - <summary>',
      })
    end,
  },
  "rhysd/conflict-marker.vim",
}
