local M = {}

function M.log_in_buffer(text)
	vim.cmd.vsplit()
	local log_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_current_buf(log_buf)
	local i = 0
	for line in string.gmatch(text, "(.-)\n") do
		vim.api.nvim_buf_set_lines(log_buf, i, i, true, { line })
		i = i + 1
	end
end

return M
