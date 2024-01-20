return {
  -- Git blame and gutters
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    keys = {
      {
        "<LEADER>gb",
        "<Cmd>Gitsigns blame_line<CR>",
        desc = "[G]it [B]lame current line",
      },
    }
  },
  "rhysd/conflict-marker.vim",
}
