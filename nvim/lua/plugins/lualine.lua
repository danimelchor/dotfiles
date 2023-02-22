local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end
lualine.setup {
    options = {
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {
            'filetype',
            {
                'filename',
                file_status = true,
                path = 1,
            },
        },
        lualine_x = {{ 'diagnostics', sources = {'nvim_lsp'}}, 'fileformat'},
        lualine_y = {'progress'},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
            },
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },
}
