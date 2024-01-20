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
}
