local mason = require "mason"
local mason_lsp = require "mason-lspconfig"
local config = require "configs.lsp"

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

require("neoconf").setup()
require("neodev").setup()

config.setup_config()

mason_lsp.setup {
	ensure_installed = { "lua_ls" },
	automatic_installation = true,
	handlers = {
		config.setup_server,
		jdtls = function() end,
	},
}

require("lspconfig").ccls.setup {
	init_options = {
		cache = {
			directory = ".ccls-cache",
		},
	},
    root_dir = require("lspconfig.util").root_pattern("compile_commands.json", '.ccls', '.git', 'Makefile'),
}
