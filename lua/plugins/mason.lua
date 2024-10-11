return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require "mason"
			mason.setup {
				ui = {
					check_outdated_packages_on_open = true,
					border = "none",
					width = 0.6,
					height = 0.6,
					icons = {
						package_installed = "👍",
						package_pending = "💫",
						package_uninstalled = "😵",
					},
				},
			}
		end,
	}, -- LSP package manager
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		lazy = false,
		config = function()
			local mason_lsp = require "mason-lspconfig"
			local lspconfig = require "lspconfig"

			mason_lsp.setup {
				ensure_installed = { "lua_ls" },
				automatic_installation = true,
				handlers = {
					function(servername)
						lspconfig[servername].setup { on_attach = require "configs.lsp.mappings" }
					end,
					jdtls = function() end,
					["csharp_ls"] = function()
						lspconfig["csharp_ls"].setup {
							on_attach = require "configs.lsp.mappings",
							handlers = {
								["textDocument/definition"] = require("csharpls_extended").handler,
							},
						}
					end,
					["omnisharp_mono"] = function()
						lspconfig["omnisharp_mono"].setup {
							on_attach = require "configs.lsp.mappings",
							filetypes = { "mono-cs" },
						}
					end,
				},
			}
		end,
	},
}
