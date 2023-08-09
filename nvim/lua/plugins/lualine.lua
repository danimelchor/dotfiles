local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end
lualine.setup {
    options = {
        theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { {
            "filename",
            file_status = true,
            path = 1,
        } },
        lualine_c = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn" },
            },
        },
        lualine_x = {
            "pay_status",
            "filetype",
        },
    },
    extensions = { "aerial", "nvim-tree", "fugitive", "fzf", "toggleterm", "quickfix", "overseer" },
}
