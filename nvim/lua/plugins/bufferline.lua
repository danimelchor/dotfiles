local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    show_close_icon = false,
    show_buffer_close_icons = false,
    offsets = {{filetype = "neo-tree", text = "File Explorer"}},
  }
})
