return {
  -- Better a/i movements
  {
    'echasnovski/mini.ai',
    version = false,
    config = function() require('mini.ai').setup() end,
  },

  -- To switch between single-line and multiline statements
  {
    'echasnovski/mini.splitjoin',
    version = false,
    config = function() require('mini.splitjoin').setup() end,
  },

  -- Move forward and backwards
  {
    'echasnovski/mini.bracketed',
    version = false,
    config = function() require('mini.bracketed').setup() end,
  },

  -- Notification pluggin & lsp loading
  {
    'echasnovski/mini.notify',
    version = false,
    config = function()
      local notify = require('mini.notify')
      notify.setup()
      vim.notify = notify.make_notify({
        ERROR = { duration = 5000 },
        WARN = { duration = 4000 },
        INFO = { duration = 2000 },
      })
    end,
  },
}
