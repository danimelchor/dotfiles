local utils = require("config.utils")
local is_stripe = utils.is_stripe()

local toggle_inlay_hint = function()
	local is_enabled = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not is_enabled)
end

local set_up_zlsp_server = function(on_attach, zlsp_bin)
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
	vim.lsp.config("zlsp", {
		on_attach = on_attach,
	})
end

local set_up_zlsp = function(on_attach)
	local cwd = vim.uv.os_homedir() .. "/stripe/zoolander"
	local cmd = {
		"python3",
		"-c",
		'from src.python.util.scripting.prebuilt import download_platform_binary; print(download_platform_binary("zlsp"), end="")',
	}
	utils.run_command(cmd, {
		cwd = cwd,
		callback = function(data)
			set_up_zlsp_server(on_attach, data)
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
		"mason-org/mason-lspconfig.nvim",
		config = function()
			if not is_stripe then
				require("neodev").setup()
			end

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

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single",
			})

			if is_stripe then
				set_up_zlsp(on_attach)
			end
		end,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},

	-- Rust config
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
	},
}
