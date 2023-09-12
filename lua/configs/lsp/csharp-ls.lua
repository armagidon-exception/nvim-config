local defaults = require "configs.lsp.default"

return {
	lsp_settings = vim.tbl_deep_extend("force", defaults.lsp_settings, {
		handlers = {
			["textDocument/definition"] = require("csharpls_extended").handler,
		},
	}),
}
