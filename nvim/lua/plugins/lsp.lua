local utils = require("config.utils")
local is_stripe = utils.is_stripe()

local toggle_inlay_hint = function()
	local is_enabled = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not is_enabled)
end

local set_up_zlsp_server = function(capabilities, on_attach, zlsp_bin)
	local server_config = require("lspconfig.configs")
	local root_pattern = require("lspconfig.util").root_pattern
	server_config.zlsp = {
		default_config = {
			autostart = false,
			cmd = {
				zlsp_bin,
				"lsp",
				"--allowlists=src/python/monolint/python/allowlist",
			},
			name = "zlsp",
			filetypes = {
				"bzl",
				"BUILD.bazel",
				"python",
			},
			root_dir = root_pattern("WORKSPACE"),
		},
	}
	require("lspconfig")["zlsp"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

local set_up_zlsp = function(capabilities, on_attach)
	local cwd = vim.uv.os_homedir() .. "/stripe/zoolander"
	local cmd = {
		"python3",
		"-c",
		'from src.python.util.scripting.prebuilt import download_platform_binary; print(download_platform_binary("zlsp"), end="")',
	}
	utils.run_command(cmd, {
		cwd = cwd,
		callback = function(data)
			set_up_zlsp_server(capabilities, on_attach, data)
		end,
	})
end

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

	vim.notify("LSP Attached (" .. client.name .. ")", vim.log.levels.INFO)
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
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, blink = pcall(require, "blink.cmp")
			if ok then
				capabilities = blink.get_lsp_capabilities(capabilities)
			end

			require("mason-lspconfig").setup({
				handlers = {
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
				},
				ensure_installed = {
					"bashls",
					"cssls",
					"eslint",
					"html",
					"jsonls",
					"lua_ls",
					-- "ocamllsp",
					"pyright",
					"ruff",
					"svelte",
					"ts_ls",
					"yamlls",
					"zls",
				},
			})

			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single",
			})

			if is_stripe then
				set_up_zlsp(capabilities, on_attach)
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
