local is_stripe = require("config.utils").is_stripe()

local toggle_inlay_hint = function()
	local is_enabled = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not is_enabled)
end

ZLSP_BIN =
'/Users/dmelchor/.cache-zoolander/prebuilt-binaries-cache/zlsp/a9acdad424ac03972d85d7f07f90a712962b5f3c01d3fcbd6a92d647d353e090/bin'

-- LSP
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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
end

return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			if not is_stripe then
				require("neodev").setup()
			end
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"lua_ls",
					"bashls",
					"cssls",
					"eslint",
					"html",
					"jsonls",
					"pyright",
					"yamlls",
					"svelte",
					"zls",
				},
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local ok, blink = pcall(require, 'blink.cmp')
			if ok then
				capabilities = blink.get_lsp_capabilities(capabilities)
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
				["lua_ls"] = function()
					require("lspconfig")["lua_ls"].setup({
						capabilities = capabilities,
						on_attach = on_attach,
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
				["gopls"] = function()
					require("lspconfig")["gopls"].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							gopls = {
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
							},
						},
					})
				end,
				["ts_ls"] = function()
					local inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = false,
					}
					require("lspconfig")["ts_ls"].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							javascript = {
								inlayHints = inlayHints,
							},
							typescript = {
								inlayHints = inlayHints,
							},
						},
					})
				end,
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single",
			})

			if is_stripe then
				local server_config = require('lspconfig.configs')
				local root_pattern = require('lspconfig.util').root_pattern
				server_config.zslp = {
					default_config = {
						cmd = {
							ZLSP_BIN,
							'lsp',
							'--buildhelper=true',
						},
						name = 'zlsp',
						filetypes = {
							'bzl',
							'BUILD.bazel',
							'python',
						},
						root_dir = root_pattern('WORKSPACE')
					}
				}
			end
		end,
		dependencies = {
			-- LSP Support
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = "BufEnter",
	},

	-- Rust config
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
	},
}
