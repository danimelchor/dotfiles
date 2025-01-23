local is_stripe = require("config.utils").is_stripe()

if is_stripe then
	return {}
end

return {
	dir = "~/projects/mindmap/mindmap.nvim",
	config = function()
		-- Open todo list
		vim.keymap.set("n", "<LEADER>ft", function()
			local file = os.getenv("HOME") .. "/notes/todos.md"
			vim.cmd("edit " .. file)
		end, {
			desc = "[F]ind [T]odos",
		})

		-- Find notes
		local fzf_lua = require("fzf-lua")
		vim.keymap.set("n", "<LEADER>fn", function()
			fzf_lua.files({
				cwd = os.getenv("HOME") .. "/notes",
				previewer = "bat",
				actions = fzf_lua.defaults.actions.files,
			})
		end, {
			desc = "[F]ind [N]otes",
		})
	end,
} or nil
