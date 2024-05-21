return {
	markdown = {
		cmd = { "sh", string.format("%s/scripts/preview_markdown.sh", vim.fn.stdpath "config"), "\"$FILE\"" },
	},
	c = {
		cmd = function()
			return { "make", "build" }
		end,
		cwd = function()
			local buf = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_active_clients { bufnr = buf }
			local root_dir = ""
			if #clients > 1 then
				root_dir = clients[1].root_dir
			else
				root_dir = vim.fn.expand "%:p:h"
			end
			return root_dir
		end,
	},

	cpp = {
		cmd = function()
			return { "make", "build" }
		end,
		cwd = function()
			local buf = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_active_clients { bufnr = buf }
			local root_dir = ""
			if #clients > 1 then
				root_dir = clients[1].root_dir
			else
				root_dir = vim.fn.expand "%:p:h"
			end
			return root_dir
		end,
	},

    tex = {
        cmd = { "pdflatex", "\"$FILE\"", "&&", "xreader", "\"$(filename $FILE).pdf\""}
    }
}
