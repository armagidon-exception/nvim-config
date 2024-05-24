vim.api.nvim_create_user_command("LatexView", function()
	local file = vim.fn.expand "%:p:r"
	require("build.builder").execute("tex", require "configs.building.buildconfig", {
		on_exit = function()
			local command = string.format("!xreader %s.pdf &", file)
			vim.cmd(command)
		end,
	})
end, {})
