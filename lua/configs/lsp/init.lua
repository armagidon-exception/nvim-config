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

local function default_on_attach(server_name, bufnr)
	local mappings = require('configs.lsp.mappings')(bufnr)
	local server_settings = get_settings(server_name)
	if server_settings then
		if server_settings.mappings then
			mappings = vim.tbl_deep_extend("force", mappings, server_settings.mappings(bufnr))
		end
	end

	mapper.create_mappings(mappings)
end

M.setup_server = function(server_name)
	local server_settings = get_settings(server_name)
	lspconfig[server_name].setup {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		on_attach = function (client, bufnr)
		  default_on_attach(server_name, bufnr)
		end,
		settings = server_settings and server_settings.settings,
		handlers = server_settings and server_settings.handlers,
        autostart = server_settings and server_settings.autostart
	}
end

return M
