local lualine = require "lualine"

local function fetch_lsp()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
end

lualine.setup {
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename", { fetch_lsp, icon = " LSP:" } },
		lualine_x = {
			"encoding",
			"fileformat",
			"filetype",
			{
				require("noice").api.status.mode.get,
				cond = require("noice").api.status.mode.has,
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
}
