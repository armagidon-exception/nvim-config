return {
	markdown = { "sh", vim.fn.stdpath "config" .. "/scripts/build_markdown.sh", "\"$FILE\"" },
	c = function()
		local buf = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_active_clients { bufnr = buf }
		local root_dir = ""
		if #clients > 1 then
			root_dir = clients[1].root_dir
		else
			root_dir = vim.fn.expand "%:p:h"
		end

		if vim.fn.filereadable(root_dir .. "/Makefile") == 1 then
			return { "cd", "\"" .. root_dir .. "\"", "&&", "make", "build" }
		else
			return { "cd", "\"" .. root_dir .. "\"", "&&", "gcc", "-Wall", "-I.", "$FILE", "-o", "\"$FILE.out\"" }
		end
	end,

	cpp = function()
		local buf = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_active_clients { bufnr = buf }
		local root_dir = ""
		if #clients > 1 then
			root_dir = clients[1].root_dir
		else
			root_dir = vim.fn.expand "%:p:h"
		end

		if vim.fn.filereadable(root_dir .. "/Makefile") == 1 then
			return { "cd", "\"" .. root_dir .. "\"", "&&", "make", "build" }
		else
			return { "cd", "\"" .. root_dir .. "\"", "&&", "g++", "-Wall", "$FILE", "-I.", "-o", "\"$FILE.out\"" }
		end
	end,
}
