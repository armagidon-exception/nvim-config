local tele_builtin = require "telescope.builtin"
local lspconfig = require "lspconfig"
local mapper = require "utils.mappings"

local M = {}

local function get_settings(server_name)
	local status, settings = pcall(require, "configs.lsp.servers." .. server_name)
	if not status then
		return false
	else
		return settings
	end
end

local function default_mappings(bufnr)
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

local function default_on_attach(server_name, bufnr)
	local mappings = default_mappings(bufnr)
	local server_settings = get_settings(server_name)
	if server_settings then
		if server_settings.mappings then
			mappings = vim.tbl_deep_extend("force", mappings, server_settings.mappings(bufnr))
		end
	end

	mapper.create_mappings(server_settings)
end

M.setup_server = function(server_name)
	local server_settings = get_settings(server_name)
	lspconfig[server_name].setup {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		on_attach = default_on_attach,
		settings = server_settings and server_settings.settings or {},
		handlers = server_settings and server_settings.handlers or {},
	}
end

return M
