local enable_diagnostics = function(value)
	vim.diagnostic.config({
		signs = value,
		underline = value,
		virtual_text = value,
		update_in_insert = false,
		float = {
			source = "always",
			border = "rounded",
			focusable = false,
		},
		severity_sort = true,
		jump = { float = true },
	})
end
enable_diagnostics(true)

vim.api.nvim_create_user_command("LintDisable", function()
	enable_diagnostics(false)
end, {
	desc = "Disable linting",
})

vim.api.nvim_create_user_command("LintEnable", function()
	enable_diagnostics(true)
end, {
	desc = "Re-enable linting",
})

return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local linters_by_ft = {
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				python = { "ruff" },
				yaml = { "yamllint" },
				markdown = { "markdownlint" },
				json = { "jsonlint" },
				proto = { "buf_lint" },
				lua = {},
			}

			-- Add "codespell" to all filetypes
			for _, linters in pairs(linters_by_ft) do
				table.insert(linters, "codespell")
			end

			local lint = require("lint")
			lint.linters_by_ft = linters_by_ft

			local codespell_args = { "-D", os.getenv("HOME") .. "/.config/codespell/custom.txt,-" }
			for _, v in pairs(lint.linters.codespell.args) do
				table.insert(codespell_args, v)
			end
			lint.linters.codespell.args = codespell_args

			local LintGroup = vim.api.nvim_create_augroup("LintGroup", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				group = LintGroup,
				callback = function()
					lint.try_lint()
					vim.notify("Linted buffer", vim.log.levels.INFO)
				end,
			})
		end,
		event = "BufEnter",
	},

	-- Errors an diagnostics
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				action_keys = {
					open_split = { "S" }, -- open buffer in new split
					open_vsplit = { "s" }, -- open buffer in new vsplit
				},
			})

			vim.keymap.set(
				"n",
				"<leader>e",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				{ noremap = true, silent = true }
			)
		end,
		event = "BufEnter",
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		config = function()
			local formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				graphql = { "prettierd" },
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
				sh = { "shfmt" },
				["_"] = { "trim_whitespace", "trim_newlines" },
				proto = { "buf" },
				ocaml = { "ocamlformat" },
				markdown = { "markdownlint" },
			}

			require("conform").setup({
				formatters_by_ft = formatters_by_ft,
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.b.disable_autoformat then
						return
					end
					return { timeout_ms = 3000, lsp_format = "fallback" }
				end,
			})

			-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
			vim.api.nvim_create_user_command("FormatDisable", function()
				vim.b.disable_autoformat = true
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			vim.api.nvim_create_user_command("Format", function()
				require("conform").format({
					timeout_ms = 500,
					lsp_fallback = true,
				}, function()
					vim.notify("Formatted buffer", vim.log.levels.INFO)
				end)
			end, {})
		end,
	},
}
