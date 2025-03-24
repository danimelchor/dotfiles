vim.keymap.set("n", '<SPACE>', '<Nop>')

-- Tmux
vim.keymap.set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux session" })

-- For practice
vim.keymap.set("n", '<UP>', '<Nop>')
vim.keymap.set("n", '<LEFT>', '<Nop>')
vim.keymap.set("n", '<RIGHT>', '<Nop>')
vim.keymap.set("n", '<DOWN>', '<Nop>')
vim.keymap.set("n", "Q", "<nop>")

-- Up and down + center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Next/Previous occurrence + center + unfold
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]]) -- Paste without yanking
vim.keymap.set("x", "<leader>d", [["_d]])  -- Delete without yanking

-- Open links
vim.keymap.set("n", "gx", function()
  local current = vim.fn.expand("<cWORD>")
  if current then
    vim.fn.jobstart("open " .. current, { detach = true })
  end
end)

-- Copy current file path from git repo root
vim.keymap.set("n", "<leader>cp", function()
  local current = vim.fn.expand("%:p")
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if current and root then
    local rel = current:gsub(root, ""):gsub("^/", "")
    vim.fn.setreg("+", rel)
    vim.notify("Copied: " .. rel)
  end
end)
