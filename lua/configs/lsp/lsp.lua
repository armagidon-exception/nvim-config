local capabilities = require("cmp_nvim_lsp").default_capabilities()
local tele_builtin = require "telescope.builtin"

local settings = {
	capabilities = capabilities,
}

function settings.mappings(bufnr)
	return {
		{
			mode = "n",
			keys = "gD",
			command = vim.lsp.buf.declaration,
			opts = {
				desc = "Show declaration",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "gd",
			command = tele_builtin.lsp_definitions,
			opts = {
				desc = "Show definitions",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "K",
			command = vim.lsp.buf.hover,
			opts = {
				desc = "Show lsp info",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "gi",
			command = tele_builtin.lsp_implementations,
			opts = {
				desc = "Show implemetation",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "<leader>k",
			command = vim.lsp.buf.signature_help,
			opts = {
				desc = "Signature help",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "<leader>D",
			command = tele_builtin.lsp_type_definitions,
			opts = {
				desc = "Show type definitions",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "<leader>rn",
			command = ":IncRename",
			opts = {
				desc = "Rename",
				buffer = bufnr,
			},
		},
		{
			mode = { "n", "v" },
			keys = "<leader>ca",
			command = require("actions-preview").code_actions,
			opts = {
				desc = "Show code actions",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "<leader>ref",
			command = tele_builtin.lsp_references,
			opts = {
				desc = "Show lsp references",
				buffer = bufnr,
			},
		},
		{
			mode = "n",
			keys = "<leader>di",
			command = tele_builtin.diagnostics,
			opts = {
				desc = "Show diagnostics",
				buffer = bufnr,
			},
		},
	}
end

return settings
