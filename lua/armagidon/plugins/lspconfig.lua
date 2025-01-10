local servers = {
	lua_ls = {
		settings = {
			format = {
				enable = false, -- let conform handle the formatting
			},
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
			hint = { enable = true },
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				codeLens = {
					enable = true,
				},
				doc = {
					privateName = { "^_" },
				},
				hint = {
					enable = true,
					setType = false,
					paramType = true,
					paramName = "Disable",
					semicolon = "Disable",
					arrayIndex = "Disable",
				},
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
	pyright = {},
	yamlls = {
		capabilities = {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		},
		settings = {
			redhat = { telemetry = { enabled = false } },
			yaml = {
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
				format = { enabled = false },
				-- anabling this conflicts between Kubernetes resources, kustomization.yaml, and Helmreleases
				validate = false,
				schemas = {
					kubernetes = "*.yaml",
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines*.{yml,yaml}",
					["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
					["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
					["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
					["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
					["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
					["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
					["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
					["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
				},
			},
		},
	},
}

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { max_width = 50, max_height = 20 }),
}

return {
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"bashls",
				"pyright",
				"cssls",
				"html",
				"cmake",
				"docker_compose_language_service",
				"jsonls",
				"pylsp",
				"taplo",
				"texlab",
				"ts_ls",
				"yamlls",
			},
		},
		config = function(_, opts)
			opts.handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = server.capabilities or {}
					server.handlers = server.handlers or {}
					local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
					local capabilities = vim.lsp.protocol.make_client_capabilities()

					server.capabilities = capabilities
					-- vim.tbl_deep_extend("force", server.capabilities, capabilities, blink_capabilities)
					server.handlers = handlers
					require("lspconfig")[server_name].setup(server)
				end,
			}
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event) end,
			})
		end,
	},
}
