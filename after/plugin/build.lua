local Terminal = require("toggleterm.terminal").Terminal

local run_cmds = {
	cs = {
		cmd = "dotnet run",
	},
}

local build_cmds = {}

vim.api.nvim_create_user_command("Run", function()
	local ft = vim.bo.filetype
	local config = run_cmds[ft]
	if not config then
		vim.notify("This filetype does not have run config", vim.log.levels.WARN)
		return
	end

	Terminal:new({
		cmd = "time " .. vim.fn.expand(config.cmd),
		on_close = function(term)
			vim.fn.chanclose(term.job_id)
		end,
		close_on_exit = false,
	}):toggle()
end, { desc = "Runs run config for given filetype" })

vim.api.nvim_create_user_command("Build", function()
	local ft = vim.bo.filetype
	local config = build_cmds[ft]
	if not config then
		vim.notify("This filetype does not have run config", vim.log.levels.WARN)
		return
	elseif type(config) == "function" then
		config = config()
	end

	Terminal:new({
		cmd = vim.fn.expand(config.cmd),
		on_close = function(term)
			vim.fn.chanclose(term.job_id)
		end,
		close_on_exit = false,
	}):toggle()
end, { desc = "Builds from config for given filetype" })

build_cmds.markdown = function()
	local buf = vim.api.nvim_get_current_buf()
	local name = vim.api.nvim_buf_get_name(buf)
	local base, _ = name:gsub("(.*)%.pdf$", "%1.pdf")
	return {
		cmd = string.format("pandoc \"%s\" -o \"%s\".pdf --from markdown+pipe_tables", name, base),
	}
end
