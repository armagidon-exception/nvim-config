local M = {}

local function create_terminal_buffer(on_close)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].filetype = "compiler"
	vim.bo[buf].buflisted = false
	vim.bo[buf].bufhidden = "wipe"
	vim.cmd.sb(buf)

	vim.api.nvim_create_autocmd({ "BufWipeout" }, {
		buffer = buf,
		callback = function(event)
			on_close()
		end,
	})

	return buf
end

local function start_terminal(cmd, opts)
	cmd = cmd or ""
	opts = opts or {}
	opts.on_close = opts.on_close or function() end
	vim.fn.win_gotoid(vim.fn.win_findbuf(opts.buffer)[1])
	local job = vim.fn.termopen(cmd, {
		detach = 0,
		env = opts.env,
		cwd = opts.cwd,
		on_exit = opts.on_exit,
	})
	return job
end

function M.run_command_in_terminal(cmd, opts)
	local job_id = nil
	local buffer = create_terminal_buffer(function()
		if job_id then
			vim.fn.jobstop(job_id)
		end
	end)
	job_id = start_terminal(cmd, vim.tbl_extend("force", opts, { buffer = buffer }))

	return { buf = buffer, job = job_id }
end

return M
