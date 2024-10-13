local M = {}
local function fetch_lsp()
	local lspconfig = require "lspconfig"
	local msg = "No Active Lsp"
	local buf_ft = vim.bo.filetype
	local clients = vim.lsp.get_clients()
	if next(clients) == nil then
		return msg
	end

	for _, client in ipairs(clients) do
		local config = lspconfig[client.name]
		if config and config.filetypes and vim.fn.index(config.filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
end

function M.get_lsp_widget()
	return { fetch_lsp, icon = " LSP:" }
end

return M
