require('bufferline').setup({
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    show_close_icon = false,
    show_buffer_close_icons = false,
    offsets = {{filetype = "neo-tree", text = "File Explorer"}},
  }
})
