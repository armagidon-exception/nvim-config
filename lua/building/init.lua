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

local current_task = {
	buffer = nil,
	job = nil,
}

function M.execute(filetype, configs, opts)
    opts = opts or {}
	local function close_existing_terminal()
		if current_task.buffer ~= nil then
			vim.cmd(string.format("bdelete! %s", current_task.buffer))
			current_task.buffer = nil
		end
	end

    local function stop_current_job()
		if current_task.job_id ~= nil then
			vim.fn.jobstop(current_task.job_id)
			current_task.job_id = nil
		end
    end
	local run_config = configs[filetype]
	if run_config == nil then
		return
	end

	local command = run_config.cmd
	if type(command) == "function" then
		command = command()
	elseif type(command) ~= "table" then
        vim.notify_once("Command must be table or a table-returning function", vim.log.levels.ERROR)
		return
	end

	local src = vim.fn.expand "%"
	command = table.concat(command, " ")

	local cwd = run_config.cwd and run_config.cwd()

    stop_current_job()
    close_existing_terminal()

	current_task.buffer = create_terminal_buffer(function()
        stop_current_job()
		current_task.buffer = nil
	end)

	current_task.job_id = start_terminal(command, {
		env = {
			FILE = src,
		},
		cwd = cwd,
		on_exit = function(id, exit_code)
			if exit_code == 0 then
                close_existing_terminal()
			end
			current_task.job_id = nil
            if opts.on_exit then
                opts.on_exit(exit_code)
            end
		end,
		buffer = current_task.buffer,
	})
end

return M
