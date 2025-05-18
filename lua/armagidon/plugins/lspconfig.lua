local servers = {
	texlab = {
		settings = {
			texlab = {
				build = {
					args = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
				},
			},
		},
	},
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
	tinymist = {
		settings = {
			projectResolution = "lockDatabase",
			formatterMode = "typstyle",
			exportPdf = "never",
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
				"cssls",
				"html",
				"cmake",
				"docker_compose_language_service",
				"jsonls",
				"taplo",
				"texlab",
				"ts_ls",
				"yamlls",
			},
			automatic_enable = false,
		},
		config = function(_, opts)
			local default_handler = function(server_name)
				local server = servers[server_name] or {}
				if type(server) == "function" then
					server = server()
				end
				server.capabilities = server.capabilities or {}
				server.handlers = server.handlers or {}
				local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
				local capabilities = vim.lsp.protocol.make_client_capabilities()

				server.capabilities = capabilities
				server.capabilities =
					vim.tbl_deep_extend("force", server.capabilities, capabilities, blink_capabilities)
				server.handlers = handlers
				require("lspconfig")[server_name].setup(server)
			end
			local mason = require "mason-lspconfig"
			mason.setup(opts)

			local server_handlers = {
				rust_analyzer = function() end,
			}
			for i, server in ipairs(mason.get_installed_servers()) do
				if not server_handlers[server] then
					default_handler(server)
				else
					server_handlers[server]()
				end
			end
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
					end

					map("<leader>ld", "<cmd>Telescope lsp_definitions<cr>", "LSP definitions")
					map("<leader>lr", "<cmd>Telescope lsp_references<cr>", "LSP references")
					map("<leader>lI", "<cmd>Telescope lsp_implentations<cr>", "LSP implementations")
					map("<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", "LSP type definitons")
					map("<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols")
					map("<leader>rn", vim.lsp.buf.rename, "LSP rename symbol")
					-- map("<leader>ca", vim.lsp.buf.code_action, "LSP code actions")
					map("<leader>gD", vim.lsp.buf.declaration, "Declaration")
					map("K", vim.lsp.buf.hover, "LSP hover")

					local clients = vim.lsp.get_clients { bufnr = 0 }
					for _, client in ipairs(clients) do
						if client.root_dir then
							vim.cmd.cd(client.root_dir)
							vim.notify "Root directory was set"
							break
						end
					end
				end,
			})
		end,
	},
}
