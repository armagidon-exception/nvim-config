return {
    cs = {"dotnet", "run"},
    markdown = {'sh', vim.fn.stdpath('config') .. '/scripts/preview_markdown.sh', "$FILE"},
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
			return { "cd", "\"" .. root_dir .. "\"", "&&", "make", "run" }
        else
            return { "cd", "\"" .. root_dir .. "\"", "&&", "gcc", "-Wall", "$FILE", "-o", "\"$FILE.out\"", "&&", "\"$FILE\".out"}
        end
	end,
}
