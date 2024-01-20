return {
  -- Code snipet images
  {
    'narutoxy/silicon.lua',
    config = function()
      local silicon = require('silicon')
      silicon.setup({
      })
      vim.keymap.set('v', '<Leader>s', function() silicon.visualise_api({ to_clip = true }) end)
    end,
    event = 'BufEnter',
  }
}
