local toggle_inlay_hint = function()
	local is_enabled = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not is_enabled)
end

-- LSP
return {
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("neodev").setup()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"cssls",
					"eslint",
					"html",
					"jsonls",
					"lua_ls",
					"ocamllsp",
					"pyright",
					"ruff",
					"svelte",
					"ts_ls",
					"yamlls",
					"zls",
				},
			})

			vim.lsp.config("*", {
				on_attach = function(client, bufnr)
					local opts = { buffer = bufnr, remap = false }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({
							border = "single",
						})
					end, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<LEADER>r", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<LEADER>a", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<LEADER>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "dh", toggle_inlay_hint, opts)

					vim.notify("LSP Attached (" .. client.name .. ")", vim.log.levels.INFO)
				end,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-parameters", "missing-fields" },
						},
						hint = { enable = true },
						telemetry = { enable = false },
					},
				},
			})
		end,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},

	-- Rust config
	{
		"mrcjkb/rustaceanvim",
		lazy = false,
	},
}
