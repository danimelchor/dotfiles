local is_stripe = require("config.utils").is_stripe()
return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		enabled = is_stripe ~= nil and is_stripe ~= false,
		config = function()
			require("copilot").setup({
				filetypes = {
					["*"] = true,
				},
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					keymap = {
						accept = false,
						accept_word = false,
						accept_line = false,
						next = false,
						prev = false,
						dismiss = false,
					},
				},
				server_opts_overrides = {
					settings = {
						advanced = {
							inlineSuggestCount = 1,
						},
					},
				},
			})
		end,
	},
}
