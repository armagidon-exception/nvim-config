local Terminal = require("toggleterm.terminal").Terminal

local function compact_vars(vars)
	local tmp = {}
	for k, v in pairs(vars) do
		table.insert(tmp, string.format("export %s=\"%s\"", k, tostring(v)))
	end

	return table.concat(tmp, " && ")
end

local function execute(filetype, configs)
	local run_config = configs[filetype]
	if run_config == nil then
		return
	end

	local command = run_config
	if type(command) == "function" then
		command = command()
	elseif type(command) ~= "table" then
		return
	end

	local vars = {
		FILE = vim.fn.expand "%:p",
	}

	local final_cmd = table.concat(command, " ")
	local variables = compact_vars(vars)

	Terminal:new({
		cmd = variables .. " && " .. final_cmd,
		on_close = function(term)
			vim.fn.chanclose(term.job_id)
		end,
		close_on_exit = false,
	}):toggle()
end

vim.api.nvim_create_user_command("Run", function()
	local ft = vim.bo.filetype
	execute(ft, require "configs.building.runconfig")
end, { desc = "Runs run config for given filetype" })

vim.api.nvim_create_user_command("Build", function()
	local ft = vim.bo.filetype
	execute(ft, require "configs.building.buildconfig")
end, { desc = "Builds from config for given filetype" })
