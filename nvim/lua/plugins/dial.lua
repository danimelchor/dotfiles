return {
  -- Better increment
  {
    "monaqa/dial.nvim",

    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })

      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true, desc = "Increment" })
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true, desc = "Decrement" })
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true, desc = "Increment" })
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true, desc = "Decrement" })
    end,
    event = "BufEnter"
  },
}
