return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = function(_, opts)
			local lspconfig = require "lspconfig"
			local function has_lsp()
				local buf_ft = vim.bo.filetype
				for _, client in ipairs(vim.lsp.get_clients() or {}) do
					local config = lspconfig[client.name]
					if config and config.filetypes and vim.fn.index(config.filetypes, buf_ft) ~= -1 then
						return true
					end
				end
                return false
			end
			local function fetch_lsp()
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

			function get_lsp_widget()
				return {
					fetch_lsp,
					cond = has_lsp,
					icon = " LSP:",
				}
			end

			table.insert(opts.sections.lualine_c, get_lsp_widget())
		end,
	},
}
