return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = function(_, opts)
			local function has_lsp()
				for _, client in ipairs(vim.lsp.get_clients() or {}) do
                    local bufnr = vim.api.nvim_get_current_buf()
                    if client.attached_buffers[bufnr] then
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
                    local bufnr = vim.api.nvim_get_current_buf()
                    if client.attached_buffers[bufnr] then
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
