return {
  -- Code snipet images
  {
    'narutoxy/silicon.lua',
    config = true,
    keys = {
      {
        '<Leader>s',
        function()
          require('silicon').visualise_api({ to_clip = true })
        end,
        mode = 'v',
        desc = 'Screenshot code snippet'
      }
    }
  }
}
