local silicon = require('silicon')
silicon.setup({
})
vim.keymap.set('v', '<Leader>s', function() silicon.visualise_api({ to_clip = true }) end)
