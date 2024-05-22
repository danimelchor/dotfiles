local RecordingAugroup = vim.api.nvim_create_augroup("Recording", { clear = true })

local function refresh_lualine()
	local status_ok, lualine = pcall(require, "lualine")
	if not status_ok then
		return
	end
	lualine.refresh({
		place = { "statusline" },
	})
end

vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = refresh_lualine,
	group = RecordingAugroup,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		local timer = vim.loop.new_timer()
		timer:start(50, 0, vim.schedule_wrap(refresh_lualine))
	end,
	group = RecordingAugroup,
})

return {
	-- Line at the bottom with status
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			opt = true,
		},
		config = function()
			local status_ok, lualine = pcall(require, "lualine")
			if not status_ok then
				return
			end

			local lint_progress = function()
				local linters = require("lint").get_running()
				if #linters == 0 then
					return ""
				end
				return " " .. table.concat(linters, ", ")
			end

			local function show_macro_recording()
				local recording_register = vim.fn.reg_recording()
				if recording_register == "" then
					return ""
				else
					return "Recording @" .. recording_register
				end
			end

			lualine.setup({
				options = {
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							show_macro_recording,
							color = { gui = "bold" },
						},
						{
							"filename",
							file_status = true,
							path = 1,
						},
					},
					lualine_c = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							sections = { "error", "warn" },
						},
					},
					lualine_x = {
						"filetype",
					},
					lualine_y = {
						lint_progress,
					},
				},
				extensions = { "aerial", "nvim-tree", "fugitive", "fzf", "toggleterm", "quickfix", "overseer" },
			})
		end,
	},
}
