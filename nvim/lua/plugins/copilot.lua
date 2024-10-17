return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			local is_stripe = require("config.utils").is_stripe()
			local enabled = is_stripe ~= nil and is_stripe ~= false

			require("copilot").setup({
				filetypes = {
					["*"] = enabled,
				},
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = enabled,
					auto_trigger = enabled,
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
