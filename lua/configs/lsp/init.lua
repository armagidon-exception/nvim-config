local M = {}

function M.get_handler(server_name)
	local status, settings = pcall(require, "configs.lsp." .. server_name)
	if not status then
		return require("configs.lsp.default").lsp_settings
	else
		return settings.lsp_settings
	end
end

return M
