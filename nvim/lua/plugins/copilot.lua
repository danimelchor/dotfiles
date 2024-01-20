return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require('copilot').setup({
        filetypes = {
          ["*"] = true,
        },
        panel = {
          enabled = false
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = false,
            accept_word = false,
            accept_line = false,
            next = false,
            prev = false,
            dismiss = false,
          }
        }
      })
    end,
  },
}
