local lsp = require('lsp-zero').preset({
  name = 'recommended',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'lua_ls',
  'gopls',
  'jdtls',
})

lsp.nvim_workspace()

-- Autocompletion
local cmp = require('cmp')
local copilot = require('copilot.suggestion')
lsp.setup_nvim_cmp({
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = 'buffer' }
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.mapping.confirm({ select = true })
      elseif copilot.is_visible() then
        copilot.accept()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  })
})

-- Create a key mapping that, on tab, will:
-- 1. If cmp is active, choose the current completion
-- 2. If cmp is not active but copilot is, choose copilots suggestion
-- 3. If neither is active, fall back to the default tab behavior

-- vim.keymap.set('i', '<Tab>', function()
--   -- Print if cmp or copilot is active
--   print('cmp: ' .. tostring(cmp.visible()))
--   print('copilot: ' .. tostring(copilot.is_visible()))
--
--   if cmp.visible() then
--     cmp.select_next_item()
--   elseif copilot.is_visible() then
--     copilot.accept()
--   else
--     vim.keymap.feedkeys('\t')
--   end
-- end)

lsp.setup()
